local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local api = vim.api

--
-- Helper function
-- conf("lsp") instead of require("user.plugins.lsp")
local function conf(config_name)
  return require(string.format("user.plugins.%s", config_name))
end

--- Use local development version if it exists.
--- @param spec table|string
local function use_local(spec)
  local name

  if type(spec) ~= "table" then
    spec = { spec }
  end

  ---@cast spec table
  if spec.name then
    name = spec.name
  else
    name = spec[1]:match(".*/(.*)")
    name = name:gsub("%.git$", "")
  end

  local local_path = spec.local_path
    or vim.env.NVIM_LOCAL_PLUGINS
    or (vim.env.HOME .. "/Personal/dev/nv-plugins")
  local path = local_path .. "/" .. name

  if vim.fn.isdirectory(path) == 1 then
    spec.dir = path
  end

  return spec
end

-- vim.g.did_load_filetypes = 1
-- vim.g.loaded_netrwPlugin = 1
vim.g.netrw_liststyle = 1
vim.g.netrw_sort_by = "exten"
vim.g.netrw_bufsettings = "noma nomod nonu nowrap ro nornu"

vim.g.markdown_fenced_languages = {
  "html",
  "python",
  "sh",
  "bash",
  "console=bash",
  "dosini",
  "ini=dosini",
  "lua",
  "cpp",
  "c++=cpp",
  "javascript",
  "java",
  "vim",
  "log",
}

--- @diagnostic disable-next-line: undefined-field
require("lazy").setup({
  -- File explorer
  {
    "stevearc/oil.nvim",
    config = conf("oil"),
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  -- Icons
  {
    "nvim-tree/nvim-web-devicons",
    name = "nvim-web-devicons",
    lazy = true,
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    config = conf("treesitter"),
  },

  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Mason: LSP/DAP/Linter installer
      {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        opts = {
          ui = {
            border = "single",
            icons = {
              package_installed = "✓",
              package_pending = "➜",
              package_uninstalled = "✗",
            },
          },
        },
      },
      {
        "williamboman/mason-lspconfig.nvim",
        opts = {
          ensure_installed = {
            "lua_ls",
            "ts_ls",
            "jsonls",
            "bashls",
          },
          automatic_installation = true,
        },
      },
      -- Neodev for better Lua LSP
      {
        "folke/neodev.nvim",
        opts = {},
      },
    },
    config = function()
      require("user.lsp")
    end,
  },

  -- Formatter
  {
    "stevearc/conform.nvim",
    config = conf("conform"),
    event = "VeryLazy",
  },

  -- Git
  use_local({
    "sindrets/vim-fugitive",
    config = conf("fugitive"),
    dependencies = {
      "tpope/vim-rhubarb",
    },
  }),

  -- Gitsigns
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    opts = {
      signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },
    },
  },

  -- Diffview (by sindrets - advanced git diff viewer)
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = conf("diffview"),
    cmd = {
      "DiffviewOpen",
      "DiffviewClose",
      "DiffviewToggleFiles",
      "DiffviewFocusFiles",
      "DiffviewRefresh",
      "DiffviewFileHistory",
    },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diffview: Open" },
      { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "Diffview: File history" },
      { "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "Diffview: Branch history" },
      { "<leader>gc", "<cmd>DiffviewClose<cr>", desc = "Diffview: Close" },
    },
  },

  -- Statusline (Feline - local plugin)
  {
    dir = vim.fn.stdpath("config") .. "/local-plugins/feline.nvim",
    name = "feline.nvim",
    config = function()
      -- Initialize feline after colorscheme
      vim.schedule(function()
        local ok, feline_config = pcall(require, "user.plugins.feline")
        if ok and type(feline_config) == "function" then
          feline_config()
        end
      end)
    end,
    dependencies = { "nvim-web-devicons", "gitsigns.nvim" },
  },

  -- behaviour
  {
    "rcarriga/nvim-notify",
    config = function()
      ---@diagnostic disable-next-line: different-requires
      local notify = require("notify") --[[@as table ]]
      notify.setup({
        max_width = 80,
        max_height = 15,
        top_down = false,
      })

      ---@diagnostic disable-next-line: duplicate-set-field
      vim.notify = function(msg, level, opts)
        opts = opts or {}
        notify(
          msg,
          level,
          vim.tbl_extend("force", opts, {
            on_open = function(winid)
              local bufid = api.nvim_win_get_buf(winid)
              -- vim.bo[bufid].filetype = "markdown"
              vim.wo[winid].conceallevel = 3
              vim.wo[winid].concealcursor = "n"
              vim.wo[winid].spell = false
              vim.treesitter.start(bufid, "markdown")

              if opts.on_open then
                opts.on_open(winid)
              end
            end,
          })
        )
      end
    end,
  },

  -- File picker (Snacks.nvim)
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    config = conf("snacks"),
  },

  -- Telescope (fuzzy finder)
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
    config = conf("telescope"),
    cmd = "Telescope",
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },
      { "<leader>fc", "<cmd>Telescope git_commits<cr>", desc = "Git commits" },
      { "<leader>fs", "<cmd>Telescope git_status<cr>", desc = "Git status" },
    },
  },

  -- Harpoon (quick file navigation)
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = conf("harpoon"),
    keys = {
      { "<leader>a", desc = "Harpoon: Add file" },
      { "<C-e>", desc = "Harpoon: Toggle menu" },
      { "<leader>1", desc = "Harpoon: Go to file 1" },
      { "<leader>2", desc = "Harpoon: Go to file 2" },
      { "<leader>3", desc = "Harpoon: Go to file 3" },
      { "<leader>4", desc = "Harpoon: Go to file 4" },
    },
  },

  -- Toggleterm
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = conf("toggleterm"),
    keys = {
      { "<c-\\>", desc = "ToggleTerm: Toggle terminal" },
    },
  },

  -- Overseer
  {
    "stevearc/overseer.nvim",
    config = conf("overseer"),
    cmd = { "OverseerRun", "OverseerToggle", "OverseerBuild" },
    keys = {
      { "<leader>or", "<cmd>OverseerRun<cr>", desc = "Overseer: Run task" },
      { "<leader>ot", "<cmd>OverseerToggle<cr>", desc = "Overseer: Toggle" },
    },
  },

  -- Neotest
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-neotest/neotest-go",
      "nvim-neotest/neotest-jest",
    },
    config = conf("neotest"),
    keys = {
      { "<leader>tt", function() require("neotest").run.run() end, desc = "Neotest: Run nearest" },
      { "<leader>tT", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Neotest: Run file" },
      { "<leader>to", function() require("neotest").output.open({ enter = true }) end, desc = "Neotest: Output" },
      { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Neotest: Summary" },
      { "<leader>tS", function() require("neotest").run.stop() end, desc = "Neotest: Stop" },
    },
  },

  -- Visual Multi
  {
    "mg979/vim-visual-multi",
    branch = "master",
  },

  -- opencode.nvim
  {
    "NickvanDyke/opencode.nvim",
    dependencies = {
      "folke/snacks.nvim",
    },
    config = conf("opencode"),
    cmd = { "Opencode" },
    keys = {
      { "<leader>oa", desc = "Opencode: Ask" },
      { "<leader>oo", desc = "Opencode: Select action" },
      { "<leader>ot", desc = "Opencode: Toggle" },
    },
  },

  -- Autotag (JSX/TSX)
  {
    "windwp/nvim-ts-autotag",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = conf("nvim-ts-autotag"),
    event = "VeryLazy",
  },

  -- Zen Mode
  {
    "folke/zen-mode.nvim",
    config = conf("zen-mode"),
    keys = {
      { "<leader>zz", "<cmd>ZenMode<cr>", desc = "ZenMode: Toggle" },
    },
  },

  -- Themes
  { "rktjmp/lush.nvim", lazy = true },
  { "arzg/vim-colors-xcode" },
  { "sainnhe/gruvbox-material" },
  { "gruvbox-community/gruvbox" },
  { "folke/tokyonight.nvim" },
  { "sindrets/material.nvim" },
  { "sindrets/rose-pine-neovim", name = "rose-pine" },
  { "mcchrish/zenbones.nvim", dependencies = "rktjmp/lush.nvim" },
  { "sainnhe/everforest" },
  { "Cybolic/palenight.vim" },
  { "olimorris/onedarkpro.nvim", branch = "main" },
  { "NTBBloodbath/doom-one.nvim" },
  { "catppuccin/nvim", name = "catppuccin" },
  { "projekt0n/github-nvim-theme" },
  { "rebelot/kanagawa.nvim" },
  {
    "AlexvZyl/nordic.nvim",
    opts = { cursorline = { hide_unfocused = false } },
  },
  { "Mofiqul/vscode.nvim" },
  { "kvrohit/rasmus.nvim" },
  -- Repo removed
  -- { "ferdinandrau/lavish.nvim" },
  { "mellow-theme/mellow.nvim" },
  { "wtfox/jellybeans.nvim" },
  { "cpwrs/americano.nvim" },
  { "dgox16/oldworld.nvim" },
  { "xeind/nightingale.nvim" },
}, {
  ui = {
    border = "single",
  },
})
