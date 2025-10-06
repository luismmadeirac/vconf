return {
	"stevearc/overseer.nvim",
	opts = {
		task_list = {
			direction = "float",
			min_width = 80,
			max_width = 120,
			min_height = 20,
			max_height = 30,
		},
	},
	keys = {
		{ "<leader>or", "<cmd>OverseerRun<cr>", desc = "Run task" },
		{ "<leader>ot", "<cmd>OverseerToggle<cr>", desc = "Task list" },
	},
}
