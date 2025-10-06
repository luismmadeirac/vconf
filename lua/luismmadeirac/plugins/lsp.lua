return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "stevearc/conform.nvim",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
    },

    config = function()
        require("conform").setup({
            formatters_by_ft = {
                lua = { "stylua" },
                go = { "gofumpt", "goimports" },
                rust = { "rustfmt" },
                javascript = { "prettier" },
                typescript = { "prettier" },
                javascriptreact = { "prettier" },
                typescriptreact = { "prettier" },
                html = { "prettier" },
                css = { "prettier" },
                scss = { "prettier" },
                json = { "prettier" },
                markdown = { "prettier" },
            },
            format_on_save = {
                timeout_ms = 500,
                lsp_fallback = true,
            },
        })
        local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())

        require("fidget").setup({})
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "rust_analyzer",
                "gopls",
                "tailwindcss",
                "ts_ls",
                "eslint",
            },
        })

        -- Configure global LSP settings
        vim.lsp.config('*', {
            capabilities = capabilities,
            root_markers = { '.git' },
        })

        -- Configure lua_ls
        vim.lsp.config('lua_ls', {
            cmd = { 'lua-language-server' },
            filetypes = { 'lua' },
            settings = {
                Lua = {
                    diagnostics = {
                        globals = {"vim"}
                    },
                    format = {
                        enable = true,
                        defaultConfig = {
                            indent_style = "space",
                            indent_size = "2",
                        }
                    },
                }
            }
        })

        -- Configure rust_analyzer
        vim.lsp.config('rust_analyzer', {
            cmd = { 'rust-analyzer' },
            filetypes = { 'rust' },
        })

        -- Configure gopls
        vim.lsp.config('gopls', {
            cmd = { 'gopls' },
            filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
        })

        -- Configure tailwindcss
        vim.lsp.config('tailwindcss', {
            cmd = { 'tailwindcss-language-server', '--stdio' },
            filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte" },
        })

        -- Configure ts_ls
        vim.lsp.config('ts_ls', {
            cmd = { 'typescript-language-server', '--stdio' },
            filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
        })

        -- Configure eslint
        vim.lsp.config('eslint', {
            cmd = { 'vscode-eslint-language-server', '--stdio' },
            filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
        })

        -- Enable all LSP servers
        vim.lsp.enable({'lua_ls', 'rust_analyzer', 'gopls', 'tailwindcss', 'ts_ls', 'eslint'})

        -- LSP keybindings on attach
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
            callback = function(event)
                local map = function(keys, func, desc)
                    vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
                end

                map('gd', vim.lsp.buf.definition, 'Goto Definition')
                map('gr', vim.lsp.buf.references, 'Goto References')
                map('gI', vim.lsp.buf.implementation, 'Goto Implementation')
                map('<leader>D', vim.lsp.buf.type_definition, 'Type Definition')
                map('<leader>rn', vim.lsp.buf.rename, 'Rename')
                map('<leader>ca', vim.lsp.buf.code_action, 'Code Action')
                map('K', vim.lsp.buf.hover, 'Hover Documentation')
                map('gD', vim.lsp.buf.declaration, 'Goto Declaration')
            end,
        })

        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            completion = {
                autocomplete = { require('cmp.types').cmp.TriggerEvent.TextChanged },
            },
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
                ['<CR>'] = cmp.mapping.confirm({ select = false }),
                ['<Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.confirm({ select = true })
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
                ['<S-Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
            }, {
                { name = 'buffer' },
            }),
            window = {
                completion = {
                    winblend = 0,
                    zindex = 50,
                },
                documentation = {
                    winblend = 0,
                    zindex = 50,
                },
            },
            formatting = {
                format = function(entry, vim_item)
                    return vim_item
                end,
            },
            experimental = {
                ghost_text = true,
            },
        })

        vim.diagnostic.config({
            -- update_in_insert = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
                winblend = 0,
                zindex = 50,
            },
        })

        -- Override LSP hover and signature help to disable transparency
        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
            vim.lsp.handlers.hover, {
                border = "rounded",
                winblend = 0,
                zindex = 999,
                -- Enable markdown rendering
                stylize_markdown = true,
            }
        )

        vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
            vim.lsp.handlers.signature_help, {
                border = "rounded",
                winblend = 0,
                zindex = 999,
            }
        )
    end
}
