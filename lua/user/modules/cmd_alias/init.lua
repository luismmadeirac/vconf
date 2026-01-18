-- lua/user/modules/cmd_alias/init.lua
-- Command alias utilities for creating short command names

local M = {}

--- Create a command alias (case-sensitive)
--- For lowercase aliases, uses cabbrev. For uppercase, uses nvim_create_user_command.
--- @param from string|string[] The alias(es) to create
--- @param to string The target command
function M.alias(from, to)
  if type(from) == "table" then
    for _, alias_name in ipairs(from) do
      M.alias(alias_name, to)
    end
    return
  end
  
  -- Check if the alias starts with lowercase
  local first_char = from:sub(1, 1)
  if first_char:match("%l") then
    -- Use cabbrev for lowercase aliases
    vim.cmd(string.format("cabbrev %s %s", from, to))
  else
    -- Use user command for uppercase aliases
    vim.api.nvim_create_user_command(from, function(opts)
      vim.cmd(to .. (opts.args ~= "" and " " .. opts.args or ""))
    end, {
      nargs = "*",
      complete = "command",
      desc = "Alias for: " .. to,
    })
  end
end

--- Create a case-insensitive command alias (using iabbrev)
--- Creates variants for all case combinations (e.g., "qa", "Qa", "qA", "QA")
--- @param from string The alias to create
--- @param to string The target command
function M.ialias(from, to)
  -- Use iabbrev for case-insensitive command-line abbreviations
  vim.cmd(string.format("iabbrev <expr> %s (getcmdtype()==':' && getcmdline()==#'%s') ? '%s' : '%s'", 
    from, from, to, from))
  
  -- Also create cabbrev variants for different cases
  local variants = { from }
  
  if #from > 0 then
    local first_upper = from:sub(1, 1):upper() .. from:sub(2)
    if first_upper ~= from then
      table.insert(variants, first_upper)
    end
    
    -- For two-letter commands, create all case variants
    if #from == 2 then
      local all_upper = from:upper()
      local second_upper = from:sub(1, 1) .. from:sub(2, 2):upper()
      
      if all_upper ~= from and all_upper ~= first_upper then
        table.insert(variants, all_upper)
      end
      if second_upper ~= from and second_upper ~= first_upper then
        table.insert(variants, second_upper)
      end
    end
  end
  
  -- Create cabbrev for each variant
  for _, variant in ipairs(variants) do
    vim.cmd(string.format("cabbrev %s %s", variant, to))
  end
end

return M
