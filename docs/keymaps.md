# Keymaps

This document lists keymaps from:
- `mappings.vim`
- `lua/user/keymaps.lua`
- Plugin keymaps defined in `lua/user/plugins/init.lua`

Leader key: `<Space>`

## Theme Switcher
- `<leader>th` — Theme picker (Telescope preview)
- `<leader>tn` — Next theme
- `<leader>tp` — Previous theme

## Mason
- `<leader>m` — Open Mason
- `<leader>mu` — Mason update
- `<leader>ml` — Mason log

## LSP (on attach)
- `gd` — Go to definition
- `gD` — Go to declaration
- `gi` — Go to implementation
- `gr` — References
- `gt` — Type definition
- `K` — Hover docs
- `<C-k>` — Signature help
- `<leader>rn` — Rename
- `<leader>ca` — Code action
- `<leader>f` — Format
- `[d` — Previous diagnostic
- `]d` — Next diagnostic
- `<leader>d` — Line diagnostics
- `<leader>q` — Diagnostics loclist
- `<leader>wa` — Add workspace folder
- `<leader>wr` — Remove workspace folder
- `<leader>wl` — List workspace folders

## Movement (display lines)
- `j/k` — Move by display lines when no count
- `<Down>/<Up>` — Same behavior as `j/k`

## Insert navigation
- `<C-h/j/k/l>` — Move left/down/up/right
- `<C-w>` — CamelCase delete word (unless only whitespace)

## Snippets (vsnip)
- `<C-f>` — Jump to next placeholder
- `<C-b>` — Jump to previous placeholder

## Line start/end
- `H` — First non-whitespace (display line)
- `L` — End of display line
- `<Home>/<End>` — First/last non-whitespace (display line)

## Clipboard/Yank
- `y/yy/Y` — Yank to `+` when default register
- `<M-p>/<M-P>` — Paste from clipboard
- `<leader>yp` — Yank relative path
- `<leader>yP` — Yank absolute path
- `<leader>yl` — Yank relative path with line
- `<leader>yL` — Yank absolute path with line

## File Explorer (Oil)
- `-` — Open Oil
- `_` — Open cwd
- `<leader>es` — Split + Oil
- `<leader>ev` — Vsplit + Oil
- `<leader>ee` — Float + Oil
- `<leader>E` — Float + Oil at cwd

## Buffers
- `<Tab>` — Next buffer
- `<S-Tab>` — Previous buffer
- `<leader><leader>` / `~` — Alternate buffer
- `<leader>w` — Close buffer (preserve layout)
- `<leader>W` — Force close buffer
- `gb` — BufferLine pick
- `X` — Smart buffer delete

## Tabs
- `<M-[>` — Previous tab
- `<M-]>` — Next tab
- `<leader>x` — Close tab
- `<leader><Tab>` — Last tab
- `<leader>1..9` — Go to tab 1..9

## Windows
- `<A-h/j/k/l>` — Move focus
- `<C-x>` — Previous window
- `<leader>v` — Vsplit
- `<leader>s` — Split
- `<C-M-h/l/j/k>` — Resize
- `<C-w>m` / `<C-w><C-m>` — WinShift
- `<C-w>X` — WinShift swap
- `<S-Arrow>` — Move window (or float)
- `<M-S-Space>` — Toggle float
- `<C-w>o` — Zoom window

## Scratchpad
- `<M-S-->` — Move scratchpad
- `<M-->` — Show scratchpad

## Journal (Neorg)
- `<leader>jo` — Journal toc
- `<leader>jj` — Journal today

## Quit/Center
- `<leader>q` / `<C-q>` — Comfy quit
- `<leader>z` — Center cursor

## Move lines
- `<A-K/J/H/L>` — Move line/indent
- `<A-Up/Down>` — Move line

## Select All
- `<C-A>` — Select all

## Readline-style (Insert/Cmdline)
- `<C-a>` — Start of line
- `<C-e>` — End of line
- `<M-b>/<M-f>` — Word back/forward
- `<M-BS>` — Kill word backward
- `<M-d>` — Kill word forward
- `<C-u>` — Kill line backward

## Search/Replace
- `<Esc>` — Clear search highlight
- `*` — Search word (no jump)
- `n/N` — Centered next/prev
- `cn` — Change word (repeatable)
- `/` — Very magic search

## Commenting
- `<C-\>` — Toggle comment (n/i/v)
- `<leader>'` — Toggle comment (n/v)

## Picker (Snacks)
- `<C-P>` — Workspace files
- `<leader>p` — Workspace files (all)
- `<C-M-P>` — Git status
- `<M-b>` — Buffers
- `<M-f>` — Grep
- `<M-O>` — Workspace symbols
- `<M-o>` — Symbols
- `<M-d>` — Diagnostics (buffer)
- `z=` — Spelling
- `<leader>fl` — Lines (ivy)
- `;;` — Resume picker

## Git
- `<leader>G` — Fugitive status (tab)
- `<leader>gs` — Fugitive status (split)
- `<leader>gl` — Git log (Flog)
- `<leader>ga` — Git add file
- `<leader>gA` — Git add all
- `<leader>gcc` — Git commit
- `<leader>gC` — Git commit (all)
- `<leader>gca` — Git commit amend
- `<leader>gb` — Git blame
- `<leader>gd` — Diffview open
- `<leader>gh` — Diffview file history
- `<leader>gH` — Diffview file history (current file)

## Diff
- `<leader>do` — Diffget (visual)
- `<leader>dp` — Diffput (visual)
- `<leader>ow` — Toggle diff iwhite

## Diagnostics/Outline
- `<A-S-D>` — Toggle diagnostics
- `<C-M-o>` — Toggle outline
- `<M-CR>` — Update messages window

## Terminal
- `<C-l>` — Toggle terminal split
- `<C-\>` — ToggleTerm
- `<Esc>` (terminal) — Normal mode
- `<M-Space>` (terminal) — Escape
- `<C-M-l>` (terminal) — Clear screen + scrollback
- `<C-s>` (visual) — Send to terminal

## Quickfix/Location
- `<M-q>` — Toggle quickfix
- `[q/ ]q` — Prev/next quickfix
- `[Q/ ]Q` — First/last quickfix
- `[l/ ]l` — Prev/next loclist
- `[L/ ]L` — First/last loclist

## References
- `[r` — Previous reference
- `]r` — Next reference

## Norwegian keybinds
- `ø` → `[`
- `æ` → `]`
- `<M-ø>` → `<M-[>`
- `<M-æ>` → `<M-]>`

## LSP (legacy mappings in mappings.vim)
- `gV` — Definition in vsplit
- `<C-w>gd` — Definition in split
- `gy` — Type definition
- `<leader>.` — Code action
- `<leader>ld` — Line diagnostics
- `<F2>` — Rename

## Format
- `<leader>ff` — Format code (conform)

## Misc
- `<leader>oc` — Toggle conceal
- `@` (visual) — Execute macro over visual range
- `<Tab>` (insert) — Smart indent
- `<M-Return>` — Insert line above
- `<F10>` — Show highlight group

## Telescope
- `<leader>ff` — Find files
- `<leader>fg` — Live grep
- `<leader>fb` — Buffers
- `<leader>fh` — Help tags
- `<leader>fr` — Recent files
- `<leader>fc` — Git commits
- `<leader>fs` — Git status

## Harpoon
- `<leader>a` — Add file
- `<C-e>` — Toggle menu
- `<leader>1..4` — Jump to file 1..4
- `<C-S-P>` — Previous harpoon
- `<C-S-N>` — Next harpoon

## Diffview
- `<leader>gd` — Open
- `<leader>gh` — File history
- `<leader>gH` — Branch history
- `<leader>gc` — Close

## Neotest
- `<leader>tt` — Run nearest
- `<leader>tT` — Run file
- `<leader>to` — Output
- `<leader>ts` — Summary
- `<leader>tS` — Stop

## Overseer
- `<leader>or` — Run task
- `<leader>ot` — Toggle

## Zen Mode
- `<leader>zz` — Toggle
