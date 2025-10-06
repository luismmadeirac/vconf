return {
  "mg979/vim-visual-multi",
  branch = "master",
  event = "VeryLazy",
  init = function()
    -- Basic settings
    vim.g.VM_theme = "iceblue"
    vim.g.VM_highlight_matches = "underline"

    -- Default mappings (customized to avoid macOS conflicts)
    vim.g.VM_maps = {
      ["Find Under"] = "<C-n>",           -- Start multi-cursor, find word under cursor
      ["Find Subword Under"] = "<C-n>",   -- Same as above
      ["Select All"] = "\\\\A",           -- Select all occurrences
      ["Start Regex Search"] = "\\\\/",   -- Start regex search
      ["Add Cursor Down"] = "<M-j>",      -- Add cursor below (Alt/Option + j)
      ["Add Cursor Up"] = "<M-k>",        -- Add cursor above (Alt/Option + k)
      ["Select l"] = "<S-Right>",         -- Select right in visual-multi mode
      ["Select h"] = "<S-Left>",          -- Select left in visual-multi mode
      ["Remove Region"] = "q",            -- Remove current region
      ["Skip Region"] = "<C-x>",          -- Skip current region
      ["Undo"] = "u",
      ["Redo"] = "<C-r>",
    }

    -- Settings
    vim.g.VM_mouse_mappings = 1           -- Enable mouse support
    vim.g.VM_silent_exit = 1              -- Don't show messages on exit
    vim.g.VM_show_warnings = 1            -- Show warnings
  end,
}
