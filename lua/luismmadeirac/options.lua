
local transparency_amount = 80

vim.opt.winblend = transparency_amount
vim.opt.pumblend = transparency_amount
vim.opt.termguicolors = true

local function disable_background()
  vim.api.nvim_set_hl(0, "Normal", { bg = "NONE", ctermbg = "NONE" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE", ctermbg = "NONE" })
  vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE", ctermbg = "NONE" })
  vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "NONE", ctermbg = "NONE" })
  vim.api.nvim_set_hl(0, "NeoTreeFloatNormal", { bg = "NONE", ctermbg = "NONE" })
end

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = disable_background,
})

disable_background()

vim.opt.showcmd = false
vim.opt.cmdheight = 1
vim.opt.shortmess:append("c")

-- Disable some popup menus
vim.opt.pumheight = 15
vim.opt.completeopt = "menu,menuone,noselect"

