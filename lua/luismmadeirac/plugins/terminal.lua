return {
  "akinsho/toggleterm.nvim",
  version = "*",
  keys = {
    {
      "<leader>tt",
      "<cmd>ToggleTerm direction=float size=20<cr>",
      mode = { "n", "t" },
      desc = "ToggleTerm (Float 20 lines)",
    },
    {
      "<leader>th",
      "<cmd>ToggleTerm direction=horizontal size=20<cr>",
      mode = { "n", "t" },
      desc = "ToggleTerm (Horizontal 20 lines)",
    },
    {
      "<leader>tV",
      "<cmd>ToggleTerm direction=vertical size=30<cr>",
      mode = { "n", "t" },
      desc = "ToggleTerm (Vertical 30 cols)",
    },
    { "<Esc><Esc>", [[<C-\><C-n>]], mode = "t", desc = "Exit Terminal Mode" },
  },
  opts = {
    size = 20,
    open_mapping = [[<c-\>]],
    hide_numbers = true,
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = true,
    insert_mappings = true,
    terminal_mappings = true,
    persist_size = true,
    persist_mode = true,
    direction = "float",
    close_on_exit = true,
    shell = vim.o.shell,
    float_opts = {
      border = "rounded",
      winblend = 0,
      highlights = {
        border = "Normal",
        background = "Full",
      },
    },
  },
  config = function(_, opts)
    require("toggleterm").setup(opts)
  end,
}
