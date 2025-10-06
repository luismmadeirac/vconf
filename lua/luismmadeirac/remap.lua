vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "=ap", "ma=ap'a")

-- vim.keymap.set("n", "<leader>zig", "<cmd>LspRestart<cr>")

vim.keymap.set("x", "<leader>p", [["_dP]])

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", '"_d')

vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww ~/.local/scripts/tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader><leader>", function()
	-- Only source if we're in a normal file buffer
	if vim.bo.buftype == "" and vim.fn.expand("%") ~= "" then
		vim.cmd("so %")
	else
		print("Cannot source this buffer type")
	end
end)


-- Go error handling vim snippets
vim.keymap.set("n", "<leader>ee", function()
	local keys = vim.api.nvim_replace_termcodes("oif err != nil {<CR>}<Esc>Oreturn err<Esc>", true, false, true)
	vim.api.nvim_feedkeys(keys, "n", false)
end)

vim.keymap.set("n", "<leader>ea", function()
	local keys = vim.api.nvim_replace_termcodes("oassert.NoError(err, \"\")<Esc>F\";a", true, false, true)
	vim.api.nvim_feedkeys(keys, "n", false)
end)

vim.keymap.set("n", "<leader>ef", function()
	local keys = vim.api.nvim_replace_termcodes("oif err != nil {<CR>}<Esc>Olog.Fatalf(\"error: %s\\n\", err.Error())<Esc>jj", true, false, true)
	vim.api.nvim_feedkeys(keys, "n", false)
end)

vim.keymap.set("n", "<leader>el", function()
	local keys = vim.api.nvim_replace_termcodes("oif err != nil {<CR>}<Esc>O.logger.Error(\"error\", \"error\", err)<Esc>F.;i", true, false, true)
	vim.api.nvim_feedkeys(keys, "n", false)
end)

