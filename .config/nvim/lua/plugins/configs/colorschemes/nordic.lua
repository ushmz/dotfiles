return {
	"AlexvZyl/nordic.nvim",
	cond = false,
	config = function()
		vim.cmd("syntax on")
		vim.opt.background = "dark"

		require("nordic").load()
	end,
}
