local M = {}

---Create a simple class with metatable-based instantiation.
---Calling the class table creates a new instance and invokes `init`.
---Each instance gets its own metatable so per-instance metamethods
---(like `__call`) don't collide.
---@param name string
---@return table
function M.create_class(name)
  local cls = {}
  cls.__index = cls
  cls.__name = name

  setmetatable(cls, {
    __call = function(self, ...)
      -- Each instance gets its own metatable that inherits from the class.
      -- This allows init() to set per-instance metamethods (e.g. __call)
      -- without overwriting the class-level metatable shared by all instances.
      local instance_mt = { __index = self }
      local instance = setmetatable({}, instance_mt)
      if instance.init then
        instance:init(...)
      end
      return instance
    end,
  })

  return cls
end

return M
