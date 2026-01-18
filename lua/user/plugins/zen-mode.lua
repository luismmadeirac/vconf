return function()
  require("zen-mode").setup({
    window = {
      width = 100,
      options = {
        number = false,
        relativenumber = false,
        cursorline = true,
      },
    },
    plugins = {
      options = {
        enabled = true,
        ruler = false,
        showcmd = false,
      },
      gitsigns = { enabled = true },
      tmux = { enabled = false },
      kitty = { enabled = false, font = "+2" },
    },
  })
end
