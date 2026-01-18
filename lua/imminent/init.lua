-- lua/imminent/init.lua
-- Shim for missing "imminent" async library
-- Provides no-op stubs for Future, spawn, and nvim_locks

local M = {}

--- @class Fut
--- @field await fun(): any
local Future = {}
Future.__index = Future

--- Create a Future from a function (no-op: executes immediately)
--- @param fn function
--- @return Fut
function M.Future.from(fn)
  local result
  local ok, err = pcall(function()
    result = fn()
  end)
  
  local fut = setmetatable({}, Future)
  fut._result = result
  fut._error = not ok and err or nil
  
  return fut
end

--- Await the future (immediately returns result)
function Future:await()
  if self._error then
    error(self._error)
  end
  return self._result
end

M.Future = setmetatable({}, {
  __index = function(_, key)
    if key == "from" then
      return function(fn)
        local result
        local ok, err = pcall(function()
          result = fn()
        end)
        
        local fut = setmetatable({}, Future)
        fut._result = result
        fut._error = not ok and err or nil
        
        return fut
      end
    end
  end
})

--- Spawn an async task (no-op: just calls pcall)
--- @param fut_fn function|Fut
function M.spawn(fut_fn)
  if type(fut_fn) == "function" then
    pcall(fut_fn)
  elseif type(fut_fn) == "table" and fut_fn.await then
    pcall(function() fut_fn:await() end)
  end
end

--- Mock nvim locks (returns a resolved future)
--- @return Fut
function M.nvim_locks()
  return M.Future.from(function() end)
end

return M
