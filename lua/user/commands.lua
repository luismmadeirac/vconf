--[[
  All commands documented in `:h sindrets-commands`.
]]

local lz = require("user.lazy")

local arg_parser = lz.require("diffview.arg_parser") ---@module "diffview.arg_parser"
local async = lz.require("imminent") ---@module "imminent"

local fmt = string.format
local utils = Config.common.utils
local notify = Config.common.notify
local api = vim.api
local command = api.nvim_create_user_command
local inspect = vim.inspect

local function get_range(c)
  return { c.range, c.line1, c.line2 }
end

local function expand_shell_arg(arg)
  local exp = vim.fn.expand(arg) --[[@as string ]]

  if exp ~= "" and exp ~= arg then
    return utils.str_quote(exp, { only_if_whitespace = true, prefer_single = true })
  end
end

command("Messages", function()
  Config.fn.update_messages_win()
end, { bar = true })

-- Temporarily stubbed commands - require Config.lib functions
--[[
command("Grep", function(c)
  Config.lib.comfy_grep(false, unpack(c.fargs))
end, { nargs = "+", complete = "file" })

command("Lgrep", function(c)
  Config.lib.comfy_grep(true, unpack(c.fargs))
end, { nargs = "+", complete = "file" })
]]

command("Terminal", "exe '<mods> sp' | exe 'term <args>'", { nargs = "*", complete = "shellcmd" })

command("TermTab", "tab sp | exe 'term' | startinsert", { bar = true })

command("Job", function(c)
  local stdout, stderr, code
  local raw_cmd = c.args
  local cmd = raw_cmd:gsub("'", "''")
  local silent = (c.smods.silent and 1 or 0) + (c.smods.emsg_silent and 1 or 0)

  ---@diagnostic disable-next-line: unused-local
  local function cb(job_id, data, event_name)
    if event_name == "stdout" then stdout = data
    elseif event_name == "stderr" then stderr = data
    elseif event_name == "exit" then
      code = data
      local notify_fn, msg, notify_opt

      if code ~= 0 then
        if silent < 2 then
          notify_fn = notify.shell.error
          notify_opt = { title = "Job exited with a non-zero status!" }
          msg = table.concat({
            "cmd: ${cmd}",
            "code: ${code}",
            "stderr: ${stderr}",
          }, "\n")
        end
      else
        if silent < 1 then
          notify_fn = notify.shell.info
          notify_opt = { title = "Job exited normally" }
          msg = table.concat({
            "cmd: ${cmd}",
            "stdout: ${stdout}",
          }, "\n")
        end
      end

      if notify_fn and msg then
        notify_fn(utils.str_template(msg, {
          cmd = raw_cmd,
          code = code,
          stderr = vim.trim(table.concat(stderr, "\n")),
          stdout = vim.trim(table.concat(stdout, "\n"))
        }), notify_opt)
      end
    end
  end

  vim.fn.jobstart(cmd, {
    on_exit = cb,
    on_stdout = cb,
    on_stderr = cb,
    stdout_buffered = true,
    stderr_buffered = true,
  })
end, { nargs = "*", complete = "shellcmd" })

--[[
-- Temporarily stubbed - requires Config.lib functions
command("HelpHere", function(c)
  Config.lib.cmd.help_here(c.args)
end, { bar = true, nargs = 1, complete = "help" })

command("ManHere", function(c)
  Config.lib.cmd.man_here(unpack(c.fargs))
end, { bar = true, nargs = 1, complete = require("man").man_complete })

command("Scratch", function(c)
  Config.lib.new_scratch_buf(c.fargs[1])
end, { bar = true, nargs = "?", complete = "filetype" })

command("SplitOn", function(c)
  Config.lib.split_on_pattern(c.args, get_range(c), c.bang)
end, { bar = true, range = true, bang = true, nargs = "?" })

command("BufRemove", function(c)
  Config.lib.remove_buffer(c.bang, tonumber(c.fargs[1]))
end, { bar = true, bang = true })

command("ReadEx", function(c)
  Config.lib.read_ex(get_range(c), unpack(c.fargs))
end, { nargs = "*", range = true, complete = "command" })
]]

command("DiffSaved", function()
  -- Stub for diff saved functionality
  vim.notify("DiffSaved not yet implemented", vim.log.levels.WARN)
end, { bar = true })

command("CloseFloats", function (c)
  local force = c.bang
  local pattern = c.fargs[1] or ".*"

  for _, id in ipairs(api.nvim_list_wins()) do
    if not utils.win_is_float(id) then goto continue end

    local bufnr = api.nvim_win_get_buf(id)
    if api.nvim_buf_get_name(bufnr):match(pattern) then
      api.nvim_win_close(id, force)
    end

    ::continue::
  end
end, { nargs = "?", bar = true, bang = true })

command("ReadMode", function ()
  if not vim.b.read_mode then
    vim.b.read_mode = true
    vim.opt_local.list = false
    vim.opt_local.nu = false
    vim.opt_local.rnu = false
    vim.opt_local.colorcolumn = ""
    vim.opt_local.conceallevel = 3
  else
    vim.b.read_mode = nil
    vim.opt_local.list = nil
    vim.opt_local.nu = nil
    vim.opt_local.rnu = nil
    vim.opt_local.colorcolumn = nil
    vim.opt_local.conceallevel = nil
  end
end, { bang = true })

command("SetIndent", function(c)
  local new_size = assert(
    tonumber(c.fargs[1]),
    fmt("IllegalArgument :: Expected number, got %s!", inspect(c.fargs[1]))
  )

  vim.opt_local.sw = new_size
  vim.opt_local.ts = new_size
  vim.opt_local.sts = new_size
end, { bar = true, nargs = 1 })

command("Reindent", function(c)
  local new_size = assert(
    tonumber(c.fargs[1]) --[[@as int ]],
    fmt("IllegalArgument :: Expected number, got %s!", inspect(c.fargs[1]))
  )
  ---@diagnostic disable-next-line: param-type-mismatch
  local cur_size = vim.opt_local.sw:get()

  local range = utils.vec_sort({ c.line1, c.line2 })
  local save_et = vim.opt_local.et:get()

  vim.opt_local.ts = cur_size
  vim.opt_local.sts = cur_size

  vim.opt_local.et = false
  vim.cmd(fmt("%d,%d retab!", range[1], range[2]))

  vim.opt_local.et = save_et
  vim.opt_local.sw = new_size
  vim.opt_local.ts = new_size
  vim.opt_local.sts = new_size
  vim.cmd(fmt("%d,%d retab!", range[1], range[2]))
end, { bar = true, nargs = 1, range = "%" })

command("Browse", function(c)
  vim.ui.open(c.fargs[1])
end, { nargs = 1, bar = true })

command("Nodiff", "windo set nodiff noscrollbind nocursorbind", { bar = true })

command("Pager", function()
  local cur_buf = api.nvim_get_current_buf()
  local term_buf = api.nvim_create_buf(false, true)
  api.nvim_win_set_buf(0, term_buf)
  local chan = api.nvim_open_term(term_buf, {})
  api.nvim_chan_send(chan, table.concat(api.nvim_buf_get_lines(cur_buf, 0, -1, false), "\n"))
  api.nvim_buf_delete(cur_buf, { force = true })
end, {})

command("ThemeToggle", function()
  -- Stub for theme toggle
  vim.notify("ThemeToggle not yet implemented", vim.log.levels.WARN)
end, { bar = true })
