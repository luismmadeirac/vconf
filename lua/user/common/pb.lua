-- lua/pb.lua
-- A compatibility shim for missing "pb" module used across config.
-- Goals:
--   - Don't crash when pb is missing
--   - Provide useful default helpers (log/inspect/notify/timers)
--   - Gracefully no-op unknown methods (optional warnings)

local M = {}

-- Toggle this to see warnings when unknown pb.* functions are called.
M._warn_unknown = false
M._warned = {}

local function warn_unknown(name)
  if not M._warn_unknown then return end
  if M._warned[name] then return end
  M._warned[name] = true
  vim.schedule(function()
    vim.notify(("pb shim: unknown function '%s' called (no-op)."):format(name), vim.log.levels.WARN)
  end)
end

-- Safe inspect (vim.inspect exists in Neovim)
local function inspect(v)
  return vim.inspect(v, { newline = "\n", indent = "  " })
end

-- Basic notify/log helpers
function M.notify(msg, level, opts)
  vim.notify(tostring(msg), level or vim.log.levels.INFO, opts)
end

function M.info(...)
  M.notify(table.concat(vim.tbl_map(tostring, { ... }), " "), vim.log.levels.INFO)
end

function M.warn(...)
  M.notify(table.concat(vim.tbl_map(tostring, { ... }), " "), vim.log.levels.WARN)
end

function M.error(...)
  M.notify(table.concat(vim.tbl_map(tostring, { ... }), " "), vim.log.levels.ERROR)
end

-- Print/inspect helpers
function M.p(...)
  -- plain print (goes to :messages)
  print(...)
end

function M.pp(v, label)
  if label then
    M.info(label .. ":\n" .. inspect(v))
  else
    M.info(inspect(v))
  end
  return v
end

function M.inspect(v)
  return inspect(v)
end

-- Timing helpers (handy if pb used for profiling)
M._timers = {}

function M.time_start(key)
  key = key or "__default__"
  M._timers[key] = vim.uv.hrtime()
end

function M.time_end(key, notify)
  key = key or "__default__"
  local t0 = M._timers[key]
  if not t0 then return nil end
  M._timers[key] = nil
  local dt_ms = (vim.uv.hrtime() - t0) / 1e6
  if notify ~= false then
    M.info(("%s: %.2fms"):format(key, dt_ms))
  end
  return dt_ms
end

-- Common “call with protection” helper
function M.try(fn, ...)
  local ok, res = pcall(fn, ...)
  if not ok then
    M.error(res)
    return nil
  end
  return res
end

-- Sometimes configs use pb.fn(...) pattern to build wrappers
M.fn = setmetatable({}, {
  __index = function(_, k)
    -- pb.fn.<name>(...) returns a function that calls pb.<name>(...)
    return function(...)
      local f = M[k]
      if type(f) == "function" then
        return f(...)
      end
      warn_unknown("fn." .. tostring(k))
      return nil
    end
  end,
})

-- Allow calling pb(...) directly as shorthand for pb.pp(...)
setmetatable(M, {
  __call = function(_, v, label)
    return M.pp(v, label)
  end,

  -- Extremely forgiving: pb.anything(...) won't crash; it'll no-op.
  __index = function(_, key)
    -- If someone does pb.some_missing_function(...)
    local name = tostring(key)
    local f = function(...)
      warn_unknown(name)
      -- Common pattern: return first arg so pipelines don't break
      return ...
    end
    rawset(M, key, f)
    return f
  end,
})

return M

