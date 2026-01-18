local uv = vim.uv or vim.loop

local CacheEntry = {}
CacheEntry.__index = CacheEntry

local function now_ms()
  return math.floor(uv.hrtime() / 1e6)
end

local function ensure_dir(dir)
  if vim.fn.isdirectory(dir) == 1 then return true end
  return vim.fn.mkdir(dir, "p") == 1
end

local function read_file(path)
  local fd = uv.fs_open(path, "r", 438) -- 0666
  if not fd then return nil end
  local stat = uv.fs_fstat(fd)
  if not stat then uv.fs_close(fd); return nil end
  local data = uv.fs_read(fd, stat.size, 0)
  uv.fs_close(fd)
  return data
end

local function write_file(path, data)
  local fd = uv.fs_open(path, "w", 438)
  if not fd then return false end
  uv.fs_write(fd, data, 0)
  uv.fs_close(fd)
  return true
end

local function json_encode(v)
  return vim.json.encode(v)
end

local function json_decode(s)
  return vim.json.decode(s, { luanil = { object = true, array = true } })
end

--- @class user.cache.CacheEntryOpts
--- @field key string
--- @field dir string
--- @field ttl_ms? integer
--- @field encode? fun(v:any):string
--- @field decode? fun(s:string):any

--- Create a cache entry for a given key.
--- Stores { meta = { ts = <ms> }, value = <any> } as JSON by default.
--- @param opts user.cache.CacheEntryOpts
function CacheEntry.new(opts)
  assert(type(opts) == "table", "CacheEntry.new(opts): opts must be a table")
  assert(type(opts.key) == "string" and opts.key ~= "", "CacheEntry.new: opts.key required")
  assert(type(opts.dir) == "string" and opts.dir ~= "", "CacheEntry.new: opts.dir required")

  local self = setmetatable({}, CacheEntry)
  self.key = opts.key
  self.dir = opts.dir
  self.ttl_ms = opts.ttl_ms
  self.encode = opts.encode or json_encode
  self.decode = opts.decode or json_decode

  ensure_dir(self.dir)

  -- Keep filename safe-ish.
  local safe = self.key:gsub("[^%w%._%-]", "_")
  self.path = self.dir .. "/" .. safe .. ".json"

  return self
end

function CacheEntry:exists()
  return uv.fs_stat(self.path) ~= nil
end

function CacheEntry:clear()
  if self:exists() then
    pcall(uv.fs_unlink, self.path)
  end
end

--- @return boolean
function CacheEntry:is_valid()
  if not self:exists() then return false end
  if not self.ttl_ms then return true end

  local raw = read_file(self.path)
  if not raw then return false end

  local ok, decoded = pcall(self.decode, raw)
  if not ok or type(decoded) ~= "table" then return false end

  local ts = decoded.meta and decoded.meta.ts
  if type(ts) ~= "number" then return false end

  return (now_ms() - ts) <= self.ttl_ms
end

--- Read value if present and valid.
--- @return any|nil
function CacheEntry:get()
  if not self:is_valid() then return nil end
  local raw = read_file(self.path)
  if not raw then return nil end

  local ok, decoded = pcall(self.decode, raw)
  if not ok or type(decoded) ~= "table" then return nil end

  return decoded.value
end

--- Write value + timestamp.
--- @param value any
--- @return boolean ok
function CacheEntry:set(value)
  local payload = {
    meta = { ts = now_ms() },
    value = value,
  }

  local ok, encoded = pcall(self.encode, payload)
  if not ok or type(encoded) ~= "string" then return false end

  ensure_dir(self.dir)
  return write_file(self.path, encoded)
end

--- Get or compute and set.
--- @param producer fun(): any
--- @return any value
function CacheEntry:compute(producer)
  local v = self:get()
  if v ~= nil then return v end
  v = producer()
  -- allow caching `nil`? Most configs don't; they treat nil as "no cache".
  if v ~= nil then
    self:set(v)
  end
  return v
end

return CacheEntry
