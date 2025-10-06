return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1002,
    config = function()
      require("catppuccin").setup({
        flavour = "auto",
        transparent_background = false,
        term_colors = true,
        integrations = {
          cmp = true,
          telescope = { enabled = true },
          treesitter = true,
          mason = true,
          neo_tree = true,
          neotest = true,
          native_lsp = { enabled = true },
        },
      })
    end,
  },
  {
    "erikbackman/brightburn.vim",
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1001,
    config = function()
      require("tokyonight").setup({
        transparent = false,
        terminal_colors = true,
        styles = {
          sidebars = "dark",
          floats = "dark",
        },
      })
    end,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 1000,
    config = function()
      require("rose-pine").setup({
        disable_background = false,
        disable_float_background = false,
        styles = {
          transparency = false,
        },
      })
    end,
  },
  {
    "zaldih/themery.nvim",
    lazy = false,
    priority = 1003,
    config = function()
      require("themery").setup({
        themes = {
          {
            name = "Catppuccin Mocha",
            colorscheme = "catppuccin-mocha",
          },
          {
            name = "Catppuccin Macchiato",
            colorscheme = "catppuccin-macchiato",
          },
          {
            name = "Catppuccin Frappe",
            colorscheme = "catppuccin-frappe",
          },
          {
            name = "Catppuccin Latte",
            colorscheme = "catppuccin-latte",
          },
          {
            name = "Rose Pine",
            colorscheme = "rose-pine",
          },
          {
            name = "Rose Pine Main",
            colorscheme = "rose-pine-main",
          },
          {
            name = "Rose Pine Moon",
            colorscheme = "rose-pine-moon",
          },
          {
            name = "Rose Pine Dawn",
            colorscheme = "rose-pine-dawn",
          },
          {
            name = "Tokyo Night",
            colorscheme = "tokyonight",
          },
          {
            name = "Tokyo Night Storm",
            colorscheme = "tokyonight-storm",
          },
          {
            name = "Tokyo Night Night",
            colorscheme = "tokyonight-night",
          },
          {
            name = "Tokyo Night Day",
            colorscheme = "tokyonight-day",
          },
          {
            name = "Brightburn",
            colorscheme = "brightburn",
          },
        },
        livePreview = true, -- Apply theme while browsing
      })

      -- Set default theme
      vim.cmd.colorscheme("catppuccin-mocha")

      -- Ensure background is properly set after colorscheme loads
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
          -- Small delay to let theme fully load
          vim.defer_fn(function()
            -- Get the theme's Normal highlight
            local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
            if normal.bg then
              -- Re-apply it to ensure it sticks
              vim.api.nvim_set_hl(0, "Normal", normal)
              vim.api.nvim_set_hl(0, "NormalNC", { bg = normal.bg, fg = normal.fg })
            end
            vim.cmd("redraw!")
          end, 10)
        end,
      })
    end,
    keys = {
      { "<leader>tc", "<cmd>Themery<cr>", desc = "Select Theme" },
    },
  },
}
