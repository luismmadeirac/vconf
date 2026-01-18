return function()
  require("overseer").setup({
    strategy = "toggleterm",
    templates = { "builtin" },
    task_list = {
      direction = "bottom",
      min_height = 12,
      max_height = 20,
      bindings = {
        ["q"] = "Close",
        ["<Esc>"] = "Close",
        ["<C-l>"] = false,
        ["<C-h>"] = false,
      },
    },
    form = {
      win_opts = {
        border = "single",
      },
    },
    confirm = {
      border = "single",
    },
  })
end
