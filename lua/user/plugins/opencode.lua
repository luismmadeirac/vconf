return function()
  vim.g.opencode_opts = {
    provider = {
      enabled = "snacks",
    },
  }

  vim.o.autoread = true

  local opencode = require("opencode")
  local map = vim.keymap.set

  map({ "n", "x" }, "<leader>oa", function()
    opencode.ask("@this: ", { submit = true })
  end, { desc = "Opencode: Ask" })

  map({ "n", "x" }, "<leader>oo", function()
    opencode.select()
  end, { desc = "Opencode: Select action" })

  map({ "n", "t" }, "<leader>ot", function()
    opencode.toggle()
  end, { desc = "Opencode: Toggle" })
end
