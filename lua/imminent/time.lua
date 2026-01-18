-- lua/imminent/time.lua
-- Shim for missing "imminent.time" timer utilities

local M = {}

--- @class Closeable
--- @field close fun()

--- Set an interval timer (uses vim.uv.new_timer)
--- @param callback function
--- @param interval number Interval in milliseconds
--- @return Closeable
function M.set_interval(callback, interval)
  local timer = vim.uv.new_timer()
  
  if not timer then
    error("Failed to create timer")
  end
  
  timer:start(interval, interval, vim.schedule_wrap(callback))
  
  return {
    close = function()
      if timer then
        timer:stop()
        timer:close()
        timer = nil
      end
    end
  }
end

--- Set a timeout timer (uses vim.uv.new_timer)
--- @param callback function
--- @param delay number Delay in milliseconds
--- @return Closeable
function M.set_timeout(callback, delay)
  local timer = vim.uv.new_timer()
  
  if not timer then
    error("Failed to create timer")
  end
  
  timer:start(delay, 0, vim.schedule_wrap(function()
    callback()
    timer:stop()
    timer:close()
  end))
  
  return {
    close = function()
      if timer then
        timer:stop()
        timer:close()
        timer = nil
      end
    end
  }
end

return M
