return function()
  require("blink.cmp").setup({
    keymap = {
      preset = "default",
      ["<Tab>"] = { "select_and_accept", "fallback" },
    },

    appearance = {
      nerd_font_variant = "mono",
    },

    completion = {
      menu = {
        border = "single",
      },
      documentation = {
        auto_show = true,
        window = {
          border = "single",
        },
      },
    },

    signature = {
      enabled = true,
      window = {
        border = "single",
      },
    },

    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
  })
end
