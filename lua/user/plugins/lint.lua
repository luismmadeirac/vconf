return function()
  local lint = require("lint")

  lint.linters_by_ft = {
    javascript = { "eslint_d" },
    javascriptreact = { "eslint_d" },
    typescript = { "eslint_d" },
    typescriptreact = { "eslint_d" },
    vue = { "eslint_d" },
    svelte = { "eslint_d" },
    go = { "golangcilint" },
  }

  local group = vim.api.nvim_create_augroup("user_nvim_lint", { clear = true })

  vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
    group = group,
    callback = function()
      local linters = lint.linters_by_ft[vim.bo.filetype]
      if linters and #linters > 0 then
        lint.try_lint()
      end
    end,
  })

  vim.keymap.set("n", "<leader>ll", function()
    lint.try_lint()
  end, { desc = "Lint: Run current buffer" })
end
