
-- Transparency disabled to allow themes to control backgrounds
local transparency_amount = 0

vim.opt.winblend = transparency_amount
vim.opt.pumblend = transparency_amount
vim.opt.termguicolors = true

-- DISABLED: This was forcing transparent backgrounds on all themes
-- local function disable_background()
--   vim.api.nvim_set_hl(0, "Normal", { bg = "NONE", ctermbg = "NONE" })
--   vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE", ctermbg = "NONE" })
--   vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE", ctermbg = "NONE" })
--   vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "NONE", ctermbg = "NONE" })
--   vim.api.nvim_set_hl(0, "NeoTreeFloatNormal", { bg = "NONE", ctermbg = "NONE" })
-- end

-- vim.api.nvim_create_autocmd("ColorScheme", {
--   pattern = "*",
--   callback = disable_background,
-- })

-- disable_background()

-- Fix Mason and Lazy window transparency/visibility
local function fix_ui_highlights()
  vim.api.nvim_set_hl(0, "MasonNormal", { bg = "#1a1b26", fg = "#c0caf5" })
  vim.api.nvim_set_hl(0, "MasonFloatBorder", { bg = "#1a1b26", fg = "#565f89" })
  vim.api.nvim_set_hl(0, "LazyNormal", { bg = "#1a1b26", fg = "#c0caf5" })
  vim.api.nvim_set_hl(0, "LazyFloatBorder", { bg = "#1a1b26", fg = "#565f89" })
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "mason", "lazy" },
  callback = function()
    vim.wo.winblend = 0  -- Disable transparency for Mason and Lazy
    fix_ui_highlights()
  end,
})

vim.opt.showcmd = false
vim.opt.cmdheight = 1
vim.opt.shortmess:append("c")

-- Disable some popup menus
vim.opt.pumheight = 15
vim.opt.completeopt = "menu,menuone,noselect"

