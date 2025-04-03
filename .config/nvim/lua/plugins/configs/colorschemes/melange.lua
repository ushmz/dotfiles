return {
	"savq/melange-nvim",
	-- cond = false,
	config = function()
		vim.cmd("syntax on")
		vim.opt.background = "dark"

		vim.api.nvim_create_autocmd({ "VimEnter" }, {
			nested = true,
			callback = function()
				vim.cmd.colorscheme("melange")
			end,
		})
	end,
}
