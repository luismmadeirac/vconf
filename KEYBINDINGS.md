# Neovim Keybindings Reference

**Leader Key:** `<Space>`

---

## Table of Contents
- [General Keybindings](#general-keybindings)
- [File Navigation](#file-navigation)
- [LSP (Language Server)](#lsp-language-server)
- [Debugging (DAP)](#debugging-dap)
- [Testing (Neotest)](#testing-neotest)
- [Git & Version Control](#git--version-control)
- [Terminal](#terminal)
- [Plugins](#plugins)
- [Keybinding Conflicts](#keybinding-conflicts)

---

## General Keybindings

| Key | Mode | Action | File |
|-----|------|--------|------|
| `<leader>pv` | n | Open file explorer (Ex) | remap.lua |
| `<leader><leader>` | n | Source current file | remap.lua |
| `<leader>f` | n | Format buffer with LSP | remap.lua |
| `<leader>s` | n | Search and replace word under cursor | remap.lua |
| `<leader>x` | n | Make file executable (chmod +x) | remap.lua |
| `Q` | n | Disabled (nop) | remap.lua |

### Clipboard Operations

| Key | Mode | Action | File |
|-----|------|--------|------|
| `<leader>y` | n, v | Yank to system clipboard | remap.lua |
| `<leader>Y` | n | Yank line to system clipboard | remap.lua |
| `<leader>p` | x | Paste without overwriting register | remap.lua |
| `<leader>d` | n, v | Delete to black hole register | remap.lua |

### Movement & Editing

| Key | Mode | Action | File |
|-----|------|--------|------|
| `J` | v | Move selected lines down | remap.lua |
| `K` | v | Move selected lines up | remap.lua |
| `J` | n | Join lines (keep cursor position) | remap.lua |
| `<C-d>` | n | Half page down (center cursor) | remap.lua |
| `<C-u>` | n | Half page up (center cursor) | remap.lua |
| `n` | n | Next search (center cursor) | remap.lua |
| `N` | n | Previous search (center cursor) | remap.lua |
| `=ap` | n | Auto-indent paragraph | remap.lua |
| `<C-c>` | i | Exit insert mode | remap.lua |

### Quickfix & Location List

| Key | Mode | Action | File |
|-----|------|--------|------|
| `<C-k>` | n | Next quickfix item | remap.lua |
| `<C-j>` | n | Previous quickfix item | remap.lua |
| `<leader>k` | n | Next location list item | remap.lua |
| `<leader>j` | n | Previous location list item | remap.lua |

### Go Error Handling Snippets

| Key | Mode | Action | File |
|-----|------|--------|------|
| `<leader>ee` | n | Insert `if err != nil { return err }` | remap.lua |
| `<leader>ea` | n | Insert `assert.NoError(err, "")` | remap.lua |
| `<leader>ef` | n | Insert `if err != nil { log.Fatalf(...) }` | remap.lua |
| `<leader>el` | n | Insert logger error handler | remap.lua |

---

## File Navigation

### Telescope (Fuzzy Finder)

| Key | Mode | Action | File |
|-----|------|--------|------|
| `<leader>pf` | n | Find files | telescope.lua |
| `<C-p>` | n | Find git files | telescope.lua |
| `<leader>ps` | n | Grep string (prompt) | telescope.lua |
| `<leader>pws` | n | Grep word under cursor | telescope.lua |
| `<leader>pWs` | n | Grep WORD under cursor | telescope.lua |
| `<leader>vh` | n | Help tags | telescope.lua |

### Harpoon (Quick File Navigation)

| Key | Mode | Action | File |
|-----|------|--------|------|
| `<leader>H` | n | Add file to Harpoon | harpoon.lua |
| `<leader>h` | n | Toggle Harpoon quick menu | harpoon.lua |
| `<leader>1` | n | Jump to Harpoon file 1 | harpoon.lua |
| `<leader>2` | n | Jump to Harpoon file 2 | harpoon.lua |
| `<leader>3` | n | Jump to Harpoon file 3 | harpoon.lua |
| `<leader>4` | n | Jump to Harpoon file 4 | harpoon.lua |
| `<leader>5` | n | Jump to Harpoon file 5 | harpoon.lua |
| `<leader>6` | n | Jump to Harpoon file 6 | harpoon.lua |
| `<leader>7` | n | Jump to Harpoon file 7 | harpoon.lua |
| `<leader>8` | n | Jump to Harpoon file 8 | harpoon.lua |

### Oil (File Explorer)

| Key | Mode | Action | File |
|-----|------|--------|------|
| `-` | n | Open Oil file browser | oil.lua |

### Neo-tree (File Tree)

| Key | Mode | Action | File |
|-----|------|--------|------|
| `<leader>fe` | n | Toggle NeoTree (root dir) | tree.lua |
| `<leader>fE` | n | Toggle NeoTree (cwd) | tree.lua |
| `<leader>e` | n | Alias for `<leader>fe` | tree.lua |
| `<leader>E` | n | Alias for `<leader>fE` | tree.lua |
| `<leader>ge` | n | Git explorer | tree.lua |
| `<leader>be` | n | Buffer explorer | tree.lua |

#### Neo-tree Window Mappings (when in Neo-tree)

| Key | Action |
|-----|--------|
| `l` | Open file/folder |
| `h` | Close node |
| `Y` | Copy path to clipboard |
| `O` | Open with system application |
| `P` | Toggle preview |

---

## LSP (Language Server)

### LSP Keybindings (Active when LSP attached)

| Key | Mode | Action | File |
|-----|------|--------|------|
| `gd` | n | Go to definition | lsp.lua, init.lua |
| `gr` | n | Go to references | lsp.lua |
| `gI` | n | Go to implementation | lsp.lua |
| `gD` | n | Go to declaration | lsp.lua |
| `K` | n | Hover documentation | lsp.lua, init.lua |
| `<leader>D` | n | Type definition | lsp.lua |
| `<leader>rn` | n | Rename symbol | lsp.lua |
| `<leader>ca` | n | Code action | lsp.lua |
| `<leader>vws` | n | Workspace symbol | init.lua |
| `<leader>vd` | n | Open diagnostic float | init.lua |
| `<leader>vca` | n | Code action (alt) | init.lua |
| `<leader>vrr` | n | References (alt) | init.lua |
| `<leader>vrn` | n | Rename (alt) | init.lua |
| `[d` | n | Previous diagnostic | init.lua |
| `]d` | n | Next diagnostic | init.lua |
| `<C-h>` | i | Signature help | init.lua |

### Completion (nvim-cmp)

| Key | Mode | Action | File |
|-----|------|--------|------|
| `<C-p>` | i | Previous completion item | lsp.lua |
| `<C-n>` | i | Next completion item | lsp.lua |
| `<C-y>` | i | Confirm completion | lsp.lua |
| `<C-Space>` | i | Trigger completion | lsp.lua |
| `<Tab>` | i | Accept completion | lsp.lua |
| `<S-Tab>` | i | Previous completion item | lsp.lua |
| `<CR>` | i | Confirm selected completion | lsp.lua |

---

## Debugging (DAP)

| Key | Mode | Action | File |
|-----|------|--------|------|
| `<F8>` | n | Continue | dap.lua |
| `<F10>` | n | Step over | dap.lua |
| `<F11>` | n | Step into | dap.lua |
| `<F12>` | n | Step out | dap.lua |
| `<leader>b` | n | Toggle breakpoint | dap.lua |
| `<leader>B` | n | Set conditional breakpoint | dap.lua |
| `<leader>dr` | n | Toggle REPL UI | dap.lua |
| `<leader>ds` | n | Toggle stacks UI | dap.lua |
| `<leader>dw` | n | Toggle watches UI | dap.lua |
| `<leader>db` | n | Toggle breakpoints UI | dap.lua |
| `<leader>dS` | n | Toggle scopes UI | dap.lua |
| `<leader>dc` | n | Toggle console UI | dap.lua |

---

## Testing (Neotest)

| Key | Mode | Action | File |
|-----|------|--------|------|
| `<leader>tr` | n | Run nearest test | neo-test.lua |
| `<leader>tv` | n | Toggle test summary | neo-test.lua |
| `<leader>ts` | n | Run test suite | neo-test.lua |
| `<leader>td` | n | Debug nearest test | neo-test.lua |
| `<leader>to` | n | Open test output | neo-test.lua |
| `<leader>ta` | n | Run all tests | neo-test.lua |

---

## Git & Version Control

### Vim Fugitive (if installed)

*No custom keybindings configured*

---

## Terminal

### ToggleTerm

| Key | Mode | Action | File |
|-----|------|--------|------|
| `<leader>tt` | n, t | Toggle floating terminal | terminal.lua |
| `<leader>th` | n, t | Toggle horizontal terminal | terminal.lua |
| `<leader>tV` | n, t | Toggle vertical terminal | terminal.lua |
| `<C-\>` | n | Open mapping | terminal.lua |
| `<Esc><Esc>` | t | Exit terminal mode | terminal.lua |

---

## Plugins

### Trouble (Diagnostics)

| Key | Mode | Action | File |
|-----|------|--------|------|
| `<leader>xx` | n | Toggle Trouble | trouble.lua |
| `[t` | n | Previous trouble item | trouble.lua |
| `]t` | n | Next trouble item | trouble.lua |

### Overseer (Task Runner)

| Key | Mode | Action | File |
|-----|------|--------|------|
| `<leader>or` | n | Run task | overseer.lua |
| `<leader>ot` | n | Toggle task list | overseer.lua |

### Undotree

| Key | Mode | Action | File |
|-----|------|--------|------|
| `<leader>u` | n | Toggle Undotree | undotree.lua |

### Zen Mode

| Key | Mode | Action | File |
|-----|------|--------|------|
| `<leader>zz` | n | Toggle Zen mode | zen-mode.lua |
| `<leader>zZ` | n | Toggle Zen mode (max width) | zen-mode.lua |

### Theme Selector (Themery)

| Key | Mode | Action | File |
|-----|------|--------|------|
| `<leader>tc` | n | Select theme | colors.lua |

### Vim Visual Multi (Multi-cursor)

| Key | Mode | Action | File |
|-----|------|--------|------|
| `<C-n>` | n | Start multi-cursor / Find next | visual-multi.lua |
| `<C-Down>` | n | Add cursor below | visual-multi.lua |
| `<C-Up>` | n | Add cursor above | visual-multi.lua |
| `<C-x>` | n | Skip current region | visual-multi.lua |
| `q` | n (VM) | Remove current region | visual-multi.lua |
| `\\A` | n | Select all occurrences | visual-multi.lua |
| `\\/` | n | Start regex search | visual-multi.lua |
| `<S-Right>` | n (VM) | Select right in VM mode | visual-multi.lua |
| `<S-Left>` | n (VM) | Select left in VM mode | visual-multi.lua |

---

## Keybinding Conflicts

### ⚠️ CONFLICTS DETECTED

| Key | Plugin 1 | Plugin 2 | Severity | Status |
|-----|----------|----------|----------|--------|
| ~~`<leader>tt`~~ | ~~ToggleTerm~~ | ~~Trouble~~ | 🔴 **HIGH** | ✅ **FIXED** |
| `<C-p>` | **Telescope** (git files) | **nvim-cmp** (previous completion) | 🟡 **MEDIUM** | ✅ **OK** |
| `<C-n>` | **nvim-cmp** (next completion) | **Vim Visual Multi** (multi-cursor) | 🟡 **MEDIUM** | ⚠️ **MINOR** |

### Conflict Resolution Status

#### 1. `<leader>tt` Conflict (HIGH Priority) - ✅ RESOLVED
**Original Issue:** Both ToggleTerm and Trouble used `<leader>tt`

**Resolution:** Trouble moved to `<leader>xx`
- ToggleTerm: `<leader>tt` (floating terminal)
- Trouble: `<leader>xx` (diagnostics)

#### 2. `<C-p>` Conflict (MEDIUM Priority)
Context-dependent:
- In insert mode: nvim-cmp navigation
- In normal mode: Telescope git files

**Status:** ✅ No conflict (different modes)

#### 3. `<C-n>` Conflict (MEDIUM Priority)
Context-dependent:
- In insert mode: nvim-cmp navigation
- In normal mode: Vim Visual Multi

**Status:** ⚠️ Potential conflict in normal mode if completion popup is visible

**Recommended Fix:**
```lua
-- Option 1: Change Visual Multi to <C-m> or <C-d>
-- Option 2: Use Alt+n instead (<A-n>)
```

---

## Additional Notes

### Leader Key Prefixes Organization

- `<leader>p*` - **Project/Find** operations (Telescope)
- `<leader>f*` - **File** operations (NeoTree, formatting)
- `<leader>t*` - **Terminal/Testing/Trouble** operations
- `<leader>d*` - **Debug** operations (DAP)
- `<leader>o*` - **Overseer** task operations
- `<leader>v*` - **LSP/Vim** operations
- `<leader>e*` - **Error/Explorer** operations
- `<leader>z*` - **Zen mode** operations
- `<leader>h/H` - **Harpoon** operations
- `<leader>1-8` - **Harpoon** file navigation

### Special Keys

- `<leader>` = `<Space>`
- `<C-*>` = Ctrl + key
- `<S-*>` = Shift + key
- `<A-*>` = Alt/Option + key
- `<F*>` = Function keys

---

**Last Updated:** $(date)
**Nvim Version:** Check with `:version`
**Config Location:** `~/.config/nvim/`

