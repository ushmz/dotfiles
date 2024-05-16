return {
	{
		"AlexvZyl/nordic.nvim",
		config = function()
			vim.cmd("syntax on")
			vim.opt.background = "dark"

			require("nordic").load()
		end,
	},
}
