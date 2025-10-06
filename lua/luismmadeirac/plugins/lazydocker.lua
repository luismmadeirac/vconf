return {
  "crnvl96/lazydocker.nvim",
  config = function()
    require("lazydocker").setup({
      window = {
        settings = {
          width = 0.9,
          height = 0.9,
          border = "rounded",
          relative = "editor",
        },
      },
    })

    -- Keymap for both normal and terminal mode
    vim.keymap.set({ "n", "t" }, "<leader>gd", function()
      require("lazydocker").toggle({ engine = "docker" })
    end, { desc = "Toggle LazyDocker" })
  end,
}
