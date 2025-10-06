return {
  "mg979/vim-visual-multi",
  branch = "master",
  event = "VeryLazy",
  init = function()
    -- Basic settings
    vim.g.VM_theme = "iceblue"
    vim.g.VM_highlight_matches = "underline"

    -- Default mappings (you can customize these)
    vim.g.VM_maps = {
      ["Find Under"] = "<C-n>",           -- Start multi-cursor, find word under cursor
      ["Find Subword Under"] = "<C-n>",   -- Same as above
      ["Select All"] = "\\\\A",           -- Select all occurrences
      ["Start Regex Search"] = "\\\\/",   -- Start regex search
      ["Add Cursor Down"] = "<C-Down>",   -- Add cursor below
      ["Add Cursor Up"] = "<C-Up>",       -- Add cursor above
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
