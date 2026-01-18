-- Harpoon 2 configuration
-- Quick file navigation similar to ThePrimeagen's workflow

return function()
  local harpoon = require("harpoon")

  -- Setup harpoon with default config
  harpoon:setup({
    settings = {
      save_on_toggle = true,
      sync_on_ui_close = true,
      key = function()
        -- Use the current working directory as the key
        return vim.loop.cwd()
      end,
    },
  })

  -- Keymaps
  local map = vim.keymap.set

  -- Add/remove files to harpoon
  map("n", "<leader>a", function()
    harpoon:list():append()
  end, { desc = "Harpoon: Add file" })

  -- Toggle harpoon UI
  map("n", "<C-e>", function()
    harpoon.ui:toggle_quick_menu(harpoon:list())
  end, { desc = "Harpoon: Toggle menu" })

  -- Navigate to files by index (1-4)
  map("n", "<leader>1", function()
    harpoon:list():select(1)
  end, { desc = "Harpoon: Go to file 1" })
  map("n", "<leader>2", function()
    harpoon:list():select(2)
  end, { desc = "Harpoon: Go to file 2" })
  map("n", "<leader>3", function()
    harpoon:list():select(3)
  end, { desc = "Harpoon: Go to file 3" })
  map("n", "<leader>4", function()
    harpoon:list():select(4)
  end, { desc = "Harpoon: Go to file 4" })

  -- Navigate to next/previous harpoon file
  map("n", "<C-S-P>", function()
    harpoon:list():prev()
  end, { desc = "Harpoon: Previous file" })
  map("n", "<C-S-N>", function()
    harpoon:list():next()
  end, { desc = "Harpoon: Next file" })
end
