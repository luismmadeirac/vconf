return {
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup {
                current_line_blame = true, -- Show inline git blame
                current_line_blame_opts = {
                    delay = 500,           -- Delay before showing blame info (in ms)
                    virt_text_pos = 'eol'  -- Position blame text at end of line
                }
            }
        end
    },
    {
        { "williamboman/mason.nvim", opts = { ensure_installed = 'prettier' } },
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
    },
    { 'sbdchd/neoformat' },
    { "sindrets/diffview.nvim" },
}
