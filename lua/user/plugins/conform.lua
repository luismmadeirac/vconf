return function()
  local pb = Config.common.pb

  --- Ordered list of formatters. Pick first available.
  local function ol(...)
    local formatters = { ... }
    formatters.stop_after_first = true
    return formatters
  end

  local prettier = ol("prettierd", "prettier")

  require("conform").setup({
    formatters_by_ft = {
      lua = { "stylua" },
      -- Conform will run multiple formatters sequentially
      python = { "isort", "black" },
      -- Use a sub-list to run only the first available formatter
      javascript = prettier,
      javascriptreact = prettier,
      typescript = prettier,
      typescriptreact = prettier,
      css = prettier,
      scss = prettier,
      sass = prettier,
      html = prettier,
      markdown = prettier,
      json = { "jq" },
      jsonc = { "deno_fmt" },
      rust = { "rustfmt" },
      bash = { "shfmt" },
      sh = { "shfmt" },
      zsh = { "shfmt" },
      make = { "trim_whitespace", "trim_newlines" },
    },
  })

  vim.opt.formatexpr = "v:lua.require'conform'.formatexpr()"

  Config.common.au.declare_group("user.conform.nvim", {}, {
    {
      "LspAttach",
      callback = function()
        vim.opt_local.formatexpr = "v:lua.require'conform'.formatexpr()"
      end,
    }
  })
end
