-- Theme switcher
local M = {}

-- List your installed themes here
M.themes = {
  -- Built-in themes
  "default",
  "habamax",
  "lunaperche",
  "vim",
  "blue",
  "darkblue",
  "delek",
  "desert",
  "elflord",
  "evening",
  "industry",
  "koehler",
  "morning",
  "murphy",
  "pablo",
  "peachpuff",
  "ron",
  "shine",
  "slate",
  "torte",
  "zellner",
  
  -- Your installed themes (add colorscheme names here)
  "xcodedark",
  "xcodelight",
  "gruvbox-material",
  "gruvbox",
  "doom-one",
  "catppuccin",
  "github_dark",
  "github_light",
  "kanagawa",
  "mellow",
  "jellybeans-nvim",
  "americano",
  "noirbuddy",
  "oxocarbon",
}

-- Current theme index
M.current_index = 1

-- Set theme
function M.set_theme(theme_name)
  local ok, err = pcall(vim.cmd.colorscheme, theme_name)
  if ok then
    vim.notify("Theme: " .. theme_name, vim.log.levels.INFO)
    -- Save current theme to sync index
    M.sync_current_theme()
    return true
  else
    vim.notify("Failed to load theme: " .. theme_name, vim.log.levels.WARN)
    return false
  end
end

-- Cycle to next theme
function M.next_theme()
  M.current_index = M.current_index + 1
  if M.current_index > #M.themes then
    M.current_index = 1
  end
  M.set_theme(M.themes[M.current_index])
end

-- Cycle to previous theme
function M.prev_theme()
  M.current_index = M.current_index - 1
  if M.current_index < 1 then
    M.current_index = #M.themes
  end
  M.set_theme(M.themes[M.current_index])
end

-- Select theme with Telescope
function M.select_theme()
  local has_telescope = pcall(require, "telescope.builtin")
  
  if has_telescope then
    vim.cmd("Telescope colorscheme enable_preview=true")
  else
    -- Fallback to vim.ui.select
    vim.ui.select(M.themes, {
      prompt = "Select theme:",
    }, function(choice)
      if choice then
        M.set_theme(choice)
      end
    end)
  end
end

-- Find current theme in list
function M.sync_current_theme()
  local current = vim.g.colors_name
  for i, theme in ipairs(M.themes) do
    if theme == current then
      M.current_index = i
      return
    end
  end
end

return M
