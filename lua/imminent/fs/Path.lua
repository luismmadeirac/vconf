-- lua/imminent/fs/Path.lua
-- Shim for missing Path library (simplified plenary.Path-like interface)

local M = {}
local uv = vim.uv or vim.loop

--- @class Path
--- @field _path string
local Path = {}
Path.__index = Path

--- Create a Path from a string
--- @param path string
--- @return Path
function M.from(path)
  local self = setmetatable({}, Path)
  self._path = path or ""
  return self
end

--- Get absolute path
--- @return Path
function Path:absolute()
  local abs = vim.fn.fnamemodify(self._path, ":p")
  return M.from(abs)
end

--- Convert to string
--- @return string
function Path:tostring()
  return self._path
end

--- Check if path exists
--- @return boolean
function Path:exists()
  return vim.fn.filereadable(self._path) == 1 or vim.fn.isdirectory(self._path) == 1
end

--- Check if path is directory
--- @return boolean
function Path:is_dir()
  return vim.fn.isdirectory(self._path) == 1
end

--- Check if path is file
--- @return boolean
function Path:is_file()
  return vim.fn.filereadable(self._path) == 1
end

--- Get parent directory
--- @return Path
function Path:parent()
  local parent = vim.fn.fnamemodify(self._path, ":h")
  return M.from(parent)
end

--- Get basename
--- @return string
function Path:basename()
  return vim.fn.fnamemodify(self._path, ":t")
end

--- Join paths
--- @param ... string
--- @return Path
function Path:join(...)
  local parts = { self._path, ... }
  local joined = table.concat(parts, "/")
  -- Normalize path separators
  joined = joined:gsub("//+", "/")
  return M.from(joined)
end

--- __tostring metamethod
function Path:__tostring()
  return self._path
end

--- __concat metamethod for path joining
function Path:__div(other)
  return self:join(tostring(other))
end

setmetatable(Path, {
  __call = function(_, path)
    return M.from(path)
  end
})

return M
