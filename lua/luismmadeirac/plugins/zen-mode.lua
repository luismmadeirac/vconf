return {
    "folke/zen-mode.nvim",
    config = function()
        require("zen-mode").setup({
            window = {
                width = 120,
                options = {}
            },
        })

        vim.keymap.set("n", "<leader>zz", function()
            require("zen-mode").toggle()
            vim.wo.wrap = false
            vim.wo.number = true
            vim.wo.rnu = true
            -- Call ColorMyPencils safely
            if _G.ColorMyPencils then
                _G.ColorMyPencils()
            end
        end)

        vim.keymap.set("n", "<leader>zZ", function()
            require("zen-mode").toggle()
            vim.wo.wrap = false
            vim.wo.number = false
            vim.wo.rnu = false
            vim.opt.colorcolumn = "0"
            -- Call ColorMyPencils safely
            if _G.ColorMyPencils then
                _G.ColorMyPencils()
            end
        end)
    end
}

