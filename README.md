# NeoVim Config v2


## Features

- **Plugin Management**: [lazy.nvim](https://github.com/folke/lazy.nvim) for fast and efficient plugin loading
- **LSP Support**: Native LSP configuration with code actions, diagnostics, and auto-completion
- **Fuzzy Finding**: Telescope for powerful file and text searching
- **Syntax Highlighting**: TreeSitter for enhanced syntax highlighting and code understanding
- **File Navigation**: Harpoon for quick file switching and Oil for file management
- **Version Control**: Seamless Git integration
- **Theme Switching**: Multiple colorschemes with easy switching (Rose Pine, Tokyo Night, Brightburn)
- **Terminal Integration**: Built-in terminal support
- **Focus Mode**: Zen mode for distraction-free coding

## Installation

1. **Backup your existing Neovim configuration:**
   ```bash
   mv ~/.config/nvim ~/.config/nvim.bak
   ```

2. **Clone this repository:**
   ```bash
   git clone <repository-url> ~/.config/nvim
   ```

3. **Launch Neovim:**
   ```bash
   nvim
   ```
   Lazy.nvim will automatically install all plugins on first launch.

## Key Plugins

- **[lazy.nvim](https://github.com/folke/lazy.nvim)** - Plugin manager
- **[telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)** - Fuzzy finder
- **[nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)** - Syntax highlighting
- **[harpoon](https://github.com/ThePrimeagen/harpoon)** - Quick file navigation
- **[oil.nvim](https://github.com/stevearc/oil.nvim)** - File explorer
- **[undotree](https://github.com/mbbill/undotree)** - Visualize undo history
- **[zen-mode.nvim](https://github.com/folke/zen-mode.nvim)** - Distraction-free coding
- **[rose-pine](https://github.com/rose-pine/neovim)** - Colorscheme
- **[tokyonight.nvim](https://github.com/folke/tokyonight.nvim)** - Colorscheme

## Clipboard

| Mapping | Action | Mode |
|---------|--------|------|
| `<leader>y` | Yank to system clipboard | Normal/Visual |
| `<leader>Y` | Yank line to system clipboard | Normal |
| `<leader>p` | Paste without overwriting register | Visual |
| `<leader>d` | Delete to black hole register | Normal/Visual |

## Configuration Structure

```
~/.config/nvim/
├── init.lua                          # Entry point
├── lua/luismmadeirac/
│   ├── init.lua                      # Main configuration
│   ├── lazy.lua                      # LazyVim setup
│   ├── set.lua                       # Vim options
│   ├── options.lua                   # Additional options
│   ├── remap.lua                     # Key mappings
│   ├── autocmds.lua                  # Auto commands
│   └── plugins/                      # Plugin configurations
│       ├── init.lua
│       ├── colors.lua
│       ├── telescope.lua
│       ├── treesitter.lua
│       ├── lsp.lua
│       ├── harpoon.lua
│       ├── oil.lua
│       ├── undotree.lua
│       ├── zen-mode.lua
│       ├── terminal.lua
│       ├── line.lua
│       ├── extras.lua
│       └── disable.lua
└── README.md
```
