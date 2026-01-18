local opt = vim.opt

local function list(items, sep)
  return table.concat(items, sep or ",")
end

-- Leader key
vim.g.mapleader = " "

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Indentation (USE SPACES, NOT TABS)
opt.autoindent = true
opt.expandtab = true        -- Convert tabs to spaces
opt.shiftwidth = 2          -- Number of spaces for each indentation level
opt.tabstop = 2             -- Number of spaces a tab counts for
opt.softtabstop = -1        -- Use shiftwidth value

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.wildignorecase = true

-- UI
opt.showcmd = true
opt.showmode = false
opt.mouse = "a"
opt.mousemoveevent = true
opt.cursorline = true
opt.cursorlineopt = list { "screenline", "number" }
opt.signcolumn = "yes:2"
opt.colorcolumn = list { "100" }

-- Splits
opt.splitbelow = true
opt.splitright = true
opt.splitkeep = "screen"

-- Wrapping
opt.wrap = true
opt.linebreak = true
opt.breakindent = true

-- Files
opt.hidden = true
opt.swapfile = true
opt.updatetime = 4096

-- Colors
opt.termguicolors = true

-- GUI font (for Neovim GUIs)
opt.guifont = "JetBrains Mono:h14"

-- Completion
opt.completeopt = list { "menuone", "noselect" }

-- Folding
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevel = 99

-- Misc
opt.scrolloff = 3
opt.backspace = list { "indent", "eol", "start" }
opt.inccommand = "split"
opt.virtualedit = list { "block" }

if vim.fn.has("nvim-0.10") == 1 then
  opt.smoothscroll = true
end

if vim.fn.has("nvim-0.11") == 1 then
  opt.winborder = "single"
end
