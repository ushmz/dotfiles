return {
	"folke/trouble.nvim",
	cmd = { "Trouble" },
	dependencies = { "nvim-tree/nvim-web-devicons" },
	---@source https://github.com/folke/trouble.nvim#setup
	opts = {
		position = "left",
	},
	event = { "VeryLazy" },
}
