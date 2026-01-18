-- Telescope configuration
-- sindrets uses Snacks.nvim, but telescope provides more features

return function()
  local telescope = require("telescope")
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  
  telescope.setup({
    defaults = {
      prompt_prefix = "  ",
      selection_caret = " ",
      multi_icon = " ",
      entry_prefix = "  ",
      initial_mode = "insert",
      selection_strategy = "reset",
      sorting_strategy = "ascending",
      layout_strategy = "horizontal",
      layout_config = {
        horizontal = {
          prompt_position = "top",
          preview_width = 0.55,
          results_width = 0.8,
        },
        vertical = {
          mirror = false,
        },
        width = 0.87,
        height = 0.80,
        preview_cutoff = 120,
      },
      file_sorter = require("telescope.sorters").get_fuzzy_file,
      file_ignore_patterns = { "node_modules", ".git/" },
      generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
      path_display = { "truncate" },
      winblend = 0,
      border = {},
      borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
      color_devicons = true,
      set_env = { ["COLORTERM"] = "truecolor" },
      file_previewer = require("telescope.previewers").vim_buffer_cat.new,
      grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
      qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
      buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
      mappings = {
        i = {
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
          ["<CR>"] = actions.select_default,
          ["<C-x>"] = actions.select_horizontal,
          ["<C-v>"] = actions.select_vertical,
          ["<C-t>"] = actions.select_tab,
          ["<C-u>"] = actions.preview_scrolling_up,
          ["<C-d>"] = actions.preview_scrolling_down,
          ["<C-c>"] = actions.close,
          ["<Esc>"] = actions.close,
        },
        n = {
          ["q"] = actions.close,
          ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
          ["j"] = actions.move_selection_next,
          ["k"] = actions.move_selection_previous,
          ["<CR>"] = actions.select_default,
        },
      },
    },
    pickers = {
      find_files = {
        -- Removed theme to ensure results show properly
        previewer = false,
        hidden = true,
        -- Telescope will auto-detect available tools (fd, rg, find)
        -- Removed explicit find_command to use defaults
      },
      git_files = {
        previewer = false,
      },
      buffers = {
        theme = "dropdown",
        previewer = false,
        initial_mode = "normal",
        mappings = {
          i = {
            ["<C-d>"] = actions.delete_buffer,
          },
          n = {
            ["dd"] = actions.delete_buffer,
          },
        },
      },
      live_grep = {
        layout_config = {
          horizontal = {
            preview_width = 0.6,
          },
        },
      },
      grep_string = {
        layout_config = {
          horizontal = {
            preview_width = 0.6,
          },
        },
      },
    },
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
    },
  })
  
  -- Load extensions
  pcall(telescope.load_extension, "fzf")
end
