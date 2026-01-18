--- Colorscheme configuration inspired by sindrets' setup
--- Handles theme setup, automatic tweaks, and color customizations

local Color = require("user.common.color").Color
local hl = require("user.common.hl")
local hi, hi_link = hl.hi, hl.hi_link

local M = {}

-- Default colorscheme settings
M.name = "americano"
M.bg = "dark"

local base = {
  diff = {
    add = "#97BE65",
    del = "#FF6C69",
    mod = "#51afef",
  },
  terminal = {
    red = "#f7768e",
    green = "#9ece6a",
    yellow = "#e0af68",
    blue = "#7aa2f7",
    magenta = "#bb9af7",
    cyan = "#7dcfff",
    white = "#a9b1d6",
    whiteBright = "#c0caf5",
  },
}

local diagnostic_kinds = { "Error", "Warn", "Info", "Hint" }

--- Check if terminal supports special underlines
function M.supports_sp_underline()
  return vim.tbl_contains({ "xterm-kitty", "wezterm" }, vim.env.TERM)
end

--- Normalize diagnostic highlights
function M.normalize_diagnostic_hl()
  local supports_underline = M.supports_sp_underline()

  for _, name in ipairs(diagnostic_kinds) do
    local color = hl.get_fg("Diagnostic" .. name)
    hi("DiagnosticSign" .. name, { fg = color, explicit = true })

    if supports_underline then
      hi("DiagnosticUnderline" .. name, {
        style = "underline",
        sp = color,
        fg = "NONE",
        explicit = true,
      })
    end
  end

  if supports_underline then
    local spell_map = {
      Bad = "Error",
      Cap = "Warn",
      Rare = "Info",
      Local = "Hint"
    }
    for spell_name, diag_name in pairs(spell_map) do
      local fg = hl.get_fg("Diagnostic" .. diag_name)
      if fg then
        hi("Spell" .. spell_name, { style = "undercurl", sp = fg, fg = "NONE", bg = "NONE" })
      end
    end
  end
end

--- Generate terminal colors
function M.generate_terminal_colors()
  if not vim.o.termguicolors then return end

  -- Generate black/gray based on Normal background
  vim.g.terminal_color_0 = Color.from_hl("Normal", "bg"):highlight(0.1):to_css()
  vim.g.terminal_color_8 = Color.from_hl("Normal", "bg"):highlight(0.2):to_css()

  -- Set ANSI colors
  vim.g.terminal_color_1  = base.terminal.red
  vim.g.terminal_color_2  = base.terminal.green
  vim.g.terminal_color_3  = base.terminal.yellow
  vim.g.terminal_color_4  = base.terminal.blue
  vim.g.terminal_color_5  = base.terminal.magenta
  vim.g.terminal_color_6  = base.terminal.cyan
  vim.g.terminal_color_7  = base.terminal.white
  vim.g.terminal_color_15 = base.terminal.whiteBright

  -- Generate bright variants
  vim.g.terminal_color_9  = Color.from_hex(vim.g.terminal_color_1):mod_value(0.15):to_css()
  vim.g.terminal_color_10 = Color.from_hex(vim.g.terminal_color_2):mod_value(0.15):to_css()
  vim.g.terminal_color_11 = Color.from_hex(vim.g.terminal_color_3):mod_value(0.15):to_css()
  vim.g.terminal_color_12 = Color.from_hex(vim.g.terminal_color_4):mod_value(0.15):to_css()
  vim.g.terminal_color_13 = Color.from_hex(vim.g.terminal_color_5):mod_value(0.15):to_css()
  vim.g.terminal_color_14 = Color.from_hex(vim.g.terminal_color_6):mod_value(0.15):to_css()
end

--- Generate diff colors
function M.generate_diff_colors()
  if not vim.o.termguicolors then return end

  local bg = vim.o.bg
  local hl_bg_normal = hl.get_bg("Normal") or (bg == "dark" and "#111111" or "#eeeeee")
  local bg_normal = Color.from_hex(hl_bg_normal)

  local base_colors = {
    add = Color.from_hex(base.diff.add),
    del = Color.from_hex(base.diff.del),
    mod = Color.from_hex(base.diff.mod),
  }

  local bg_add = base_colors.add:blend(bg_normal, 0.85):mod_saturation(0.05)
  local bg_add_text = base_colors.add:blend(bg_normal, 0.7):mod_saturation(0.05)
  local bg_del = base_colors.del:blend(bg_normal, 0.85):mod_saturation(0.05)
  local bg_del_text = base_colors.del:blend(bg_normal, 0.7):mod_saturation(0.05)
  local bg_mod = base_colors.mod:blend(bg_normal, 0.85):mod_saturation(0.05)
  local bg_mod_text = base_colors.mod:blend(bg_normal, 0.7):mod_saturation(0.05)

  -- Builtin groups
  hi("@diff.plus", { fg = base_colors.add:to_css(), explicit = true })
  hi("@diff.minus", { fg = base_colors.del:to_css(), explicit = true })
  hi("@diff.delta", { fg = base_colors.mod:to_css(), explicit = true })

  hi("DiffAdd", { bg = bg_add:to_css(), explicit = true })
  hi("DiffDelete", { bg = bg_del:to_css(), explicit = true })
  hi("DiffChange", { bg = bg_mod:to_css(), explicit = true })
  hi("DiffText", { bg = bg_mod_text:to_css(), fg = base_colors.mod:to_css(), explicit = true })

  hi("diffAdded", { fg = base_colors.add:to_css(), explicit = true })
  hi("diffRemoved", { fg = base_colors.del:to_css(), explicit = true })
  hi("diffChanged", { fg = base_colors.mod:to_css(), explicit = true })

  -- Custom groups
  hi("DiffAddText", { bg = bg_add_text:to_css(), fg = base_colors.add:to_css(), explicit = true })
  hi("DiffDeleteText", { bg = bg_del_text:to_css(), fg = base_colors.del:to_css(), explicit = true })

  hi_link("Added", "@diff.plus", { clear = true })
  hi_link("Removed", "@diff.minus", { clear = true })
  hi_link("Changed", "@diff.delta", { clear = true })
end

--- Find base colors for the theme
function M.find_base_colors()
  local primary = Color.from_hl({ "Function", "Title", "Normal" }, "fg")
  local accent

  for _, name in ipairs({ "@function.builtin", "Statement", "Constant", "Title" }) do
    local color = Color.from_hl(name, "fg")
    if color and color:to_hex() ~= primary:to_hex() then
      accent = color
      break
    end
  end

  return {
    primary = primary,
    accent = accent or primary,
  }
end

--- Configure nightingale colorscheme before loading
function M.setup_nightingale()
  -- Configure nightingale with darker background
  require("nightingale").setup({
    colors = {
      bg = "#0a0a0a",        -- Much darker background (near-black)
      bg_alt = "#0f0f0f",    -- Slightly lighter for splits/sidebars
    }
  })
end

--- Apply tweaks after loading the colorscheme
function M.apply_tweaks()
  if not vim.o.termguicolors then
    require("user.common.utils").warn(
      "'termguicolors' is not set! Color scheme tweaks might have unexpected results!"
    )
    return
  end

  local fg_normal = Color.from_hl("Normal", "fg")
  if not fg_normal then return end

  local bg = vim.o.bg
  local bg_normal = Color.from_hl("Normal", "bg")
      or Color.from_hex(bg == "dark" and "#111111" or "#eeeeee")
  local base_colors = M.find_base_colors()

  local bg_override = (vim.g.colors_name == "americano") and "#0e0e0e" or nil
  if bg_override then
    -- Force darker background for americano
    hi("Normal", { bg = bg_override })
    hi("NormalNC", { bg = bg_override })  -- Non-current windows
  end
  
  -- Basic highlights
  hi("Hidden", { fg = "bg", bg = "bg" })
  hi("Primary", { fg = base_colors.primary:to_css() })
  hi("Accent", { fg = base_colors.accent:to_css() })

  -- Whitespace and visual elements
  hi("Whitespace", { fg = bg_normal:highlight(0.16):to_css() })
  hi({ "CursorLine", "ColorColumn" }, { bg = bg_normal:highlight(0.04):to_css(), explicit = true })
  hi("Visual", { bg = "#adb1b4", fg = "NONE" })
  hi("VisualNOS", { bg = "#adb1b4", fg = "NONE" })
  hi("VisualLine", { bg = "#adb1b4", fg = "NONE" })
  hi("VisualBlock", { bg = "#adb1b4", fg = "NONE" })

  -- Remove backgrounds from sign column, line numbers, etc.
  hi({ "LineNr", "CursorLineNr", "SignColumn", "FoldColumn" }, { bg = "NONE" })
  
  -- Make line numbers more subtle
  hi("LineNr", { fg = bg_normal:highlight(0.25):to_css() })
  hi("CursorLineNr", { fg = base_colors.primary:to_css(), gui = "bold" })

  -- Diff highlights
  M.generate_diff_colors()

  -- Terminal colors
  M.generate_terminal_colors()

  -- Diagnostics
  M.normalize_diagnostic_hl()

  -- LSP Reference highlighting
  hi("LspReferenceText", {
    bg = Color.from_hl("CursorLine", "bg"):highlight(0.08):to_css(),
    explicit = true,
  })
  hi_link({ "LspReferenceRead", "LspReferenceWrite" }, "LspReferenceText", { clear = true })

  -- Treesitter
  hi_link({ "@conditional", "@repeat" }, "Keyword", { clear = true })
  hi("@text.emphasis", { style = "italic" })
  hi({ "@text.uri", "@markup.link" }, { style = "underline" })
  
  -- Generate dimmed colors for statusline (used by lualine)
  for i = 1, 9 do
    local amount = 0.05 + (i * 0.05)  -- 0.1 to 0.5
    local dimmed = fg_normal:mod_value(-amount):to_css()
    hi("StatusLineDim" .. (i * 100), { fg = dimmed })
  end

  -- GitSigns
  hi_link("GitSignsAdd", "@diff.plus", { clear = true })
  hi_link("GitSignsDelete", "@diff.minus", { clear = true })
  hi_link("GitSignsChange", "@diff.delta", { clear = true })
end

--- Main function to set up and apply the colorscheme
function M.setup()
  -- Set up nightingale before loading
  if M.name == "nightingale" then
    M.setup_nightingale()
  end

  -- Load the colorscheme
  vim.cmd.colorscheme(M.name)

  -- Apply tweaks
  vim.schedule(function()
    M.apply_tweaks()
  end)
end

--- Apply the colorscheme configuration
function M.apply()
  -- Create autocmds for colorscheme changes
  local group = vim.api.nvim_create_augroup("colorscheme_config", { clear = true })
  
  vim.api.nvim_create_autocmd("ColorScheme", {
    group = group,
    callback = function()
      vim.schedule(function()
        M.apply_tweaks()
      end)
    end,
  })

  -- Set up the initial colorscheme
  M.setup()
end

return M
