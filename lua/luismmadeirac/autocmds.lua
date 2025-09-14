vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = {
    "*.tsx",
    "*.jsx",
    "*.ts",
    "*.js",
    "*.md",
    "*.txt",
    "*.tex",
    "gitcommit",
  },
  callback = function()
    vim.opt_local.spell = true
  end,
})
