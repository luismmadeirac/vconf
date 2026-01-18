-- LSP, Mason, and Theme keymaps

local map = vim.keymap.set

-- Theme Switcher
local theme_switcher = require("user.theme-switcher")
map("n", "<leader>th", theme_switcher.select_theme, { desc = "Theme: Select with picker" })
map("n", "<leader>tn", theme_switcher.next_theme, { desc = "Theme: Next" })
map("n", "<leader>tp", theme_switcher.prev_theme, { desc = "Theme: Previous" })

-- Mason
map("n", "<leader>m", "<cmd>Mason<cr>", { desc = "Mason: Open installer" })
map("n", "<leader>mu", "<cmd>MasonUpdate<cr>", { desc = "Mason: Update all packages" })
map("n", "<leader>ml", "<cmd>MasonLog<cr>", { desc = "Mason: Open log" })

-- LSP keymaps (set on LspAttach)
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    local opts = { buffer = ev.buf }
    
    -- Navigation
    map("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "LSP: Go to definition" }))
    map("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "LSP: Go to declaration" }))
    map("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "LSP: Go to implementation" }))
    map("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "LSP: Show references" }))
    map("n", "gt", vim.lsp.buf.type_definition, vim.tbl_extend("force", opts, { desc = "LSP: Go to type definition" }))
    
    -- Hover and help
    map("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "LSP: Hover documentation" }))
    map("n", "<C-k>", vim.lsp.buf.signature_help, vim.tbl_extend("force", opts, { desc = "LSP: Signature help" }))
    
    -- Actions
    map("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "LSP: Rename" }))
    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "LSP: Code action" }))
    map("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, vim.tbl_extend("force", opts, { desc = "LSP: Format" }))
    
    -- Diagnostics
    map("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", opts, { desc = "LSP: Previous diagnostic" }))
    map("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, { desc = "LSP: Next diagnostic" }))
    map("n", "<leader>d", vim.diagnostic.open_float, vim.tbl_extend("force", opts, { desc = "LSP: Show diagnostic" }))
    map("n", "<leader>q", vim.diagnostic.setloclist, vim.tbl_extend("force", opts, { desc = "LSP: Diagnostic loclist" }))
    
    -- Workspace
    map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, vim.tbl_extend("force", opts, { desc = "LSP: Add workspace folder" }))
    map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, vim.tbl_extend("force", opts, { desc = "LSP: Remove workspace folder" }))
    map("n", "<leader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, vim.tbl_extend("force", opts, { desc = "LSP: List workspace folders" }))
  end,
})
