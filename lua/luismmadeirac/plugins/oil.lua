return {
  "stevearc/oil.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    default_file_explorer = false,
    columns = {
      "icon",
    },
    view_options = {
      show_hidden = true,
      natural_sort = true,
      sort_dirs_first = true,
    },
    float = {
      max_width = 100,
      max_height = 40,
      border = "rounded",
      win_options = {
        winblend = 10,
      },
    },
    skip_confirm_for_simple_edits = true,
    keymaps = {
      ["<Esc>"] = { "actions.close", mode = "n" },
    },
  },
  config = function(_, opts)
    require("oil").setup(opts)
    vim.keymap.set("n", "-", function()
      require("oil").open_float()
    end, { desc = "Open parent directory with oil.nvim (float)" })
  end,
}
