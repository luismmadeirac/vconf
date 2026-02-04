# Neovim configuration

This repository lives in `~/.config/nvim` and is my personal Neovim setup powered by Lua, `lazy.nvim`, and a mix of curated plugins. The goal is to stay fast, responsive, and workspace-aware while leaning on composable modules (see `lua/user`) that can be extended from other machines.

## Requirements

- Neovim 0.10+ (I develop against the latest stable release and some plugins rely on the newer Lua APIs).
- `git` (used by `lazy.nvim` to bootstrap itself and install plugins).
- Optional: `build-essential` / equivalent toolchain for native builds (`telescope-fzf-native`, `snacks.nvim`, etc.).

## Setup

1. Clone the repo to `~/.config/nvim`.
2. Start Neovim: `nvim --headless -c 'Lazy sync' -c 'qa'` to install plugins without opening the UI.
3. Close Neovim and reopen normally; `lazy.nvim` handles future updates from `:Lazy sync` or `:Lazy update`.
4. (Optional) Set `NVIM_LOCAL_PLUGINS` if you develop against local plugin sources.

## Repository structure

- `init.lua`: entry point. Sets up globals (`Config`, `Path`, `pb`) and registers autocmds plus helper functions.
- `lua/user/`: configurable modules for keymaps, plugin configs, LSP, utilities, and lazy-loading helpers.
- `docs/keymaps.md`: consolidated cheat sheet for the leader key, modules, and frequently used mappings.
- `local-plugins/`: home for local plugin overrides (e.g., `feline.nvim`).
- `mappings.vim`, `autocommands.vim`, `lua/user/au.lua`, and friends augment legacy VimScript or bootstrap behaviors.

## Key highlights

- Lazy-loaded plugin tree managed via `lua/user/plugins/init.lua` with helpers for local forks.
- Custom UI helpers in `lua/user/lib.lua` and `Config.fn.*` togglers for quickfix, diagnostics, outline, and message windows.
- Theme picker, snack-based pickers, Neorg/Harpoon/Overseer/neotest integrations, and curated terminal helpers (e.g., `toggleterm`, `Trouble`, `Oil`).
- Notification system replaces `vim.notify` with `nvim-notify` for polished popups.

## Customization tips

- Update `lua/user/settings.lua` or the modules inside `lua/user/plugins/` to swap colors, change defaults, or tweak plugin options.
- Inspect `lua/user/keymaps.lua` and `docs/keymaps.md` before adding new shortcuts to avoid conflicts.
- Use `:Lazy home` or explore `lua/user/lazy.lua` to understand how modules are lazy-loaded.

Feel free to fork, tweak, or prune plugins to match your workflow—this setup is intentionally modular to make those changes easy.
