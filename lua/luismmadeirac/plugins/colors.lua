function ColorMyPencils(color)
  color = color or "rose-pine-moon"
  vim.cmd.colorscheme(color)

  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

_G.ColorMyPencils = ColorMyPencils

local themes = {
  "rose-pine",
  "rose-pine-main",
  "rose-pine-moon",
  "rose-pine-dawn",
  "tokyonight",
  "tokyonight-storm",
  "tokyonight-night",
  "tokyonight-day",
  "brightburn",
}

-- Theme switcher function
local function switch_theme()
  vim.ui.select(themes, {
    prompt = "Select a theme:",
    format_item = function(item)
      return item
    end,
  }, function(choice)
    if choice then
      ColorMyPencils(choice)
      print("Applied theme: " .. choice)
    end
  end)
end

vim.api.nvim_create_user_command("ThemeSwitch", switch_theme, {})
vim.keymap.set("n", "<leader>ts", switch_theme, { desc = "Switch Theme" })

vim.keymap.set("n", "<leader>trp", function()
  ColorMyPencils("rose-pine-moon")
end, { desc = "Rose Pine Moon" })

vim.keymap.set("n", "<leader>ttn", function()
  ColorMyPencils("tokyonight-storm")
end, { desc = "Tokyo Night Storm" })

return {
  {
    "erikbackman/brightburn.vim",
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        style = "storm",
        transparent = true,
        terminal_colors = true,
        styles = {
          comments = { italic = false },
          keywords = { italic = false },
          sidebars = "dark",
          floats = "dark",
        },
        on_colors = function(colors) end,
        on_highlights = function(highlights, colors) end,
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
        disable_float_background = true,
        styles = {
          italic = false,
          transparency = true,
        },
      })
      ColorMyPencils("rose-pine-moon")
    end,
  },
}
