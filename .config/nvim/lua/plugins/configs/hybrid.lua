return {
	"w0ng/vim-hybrid",
	config = function()
		vim.cmd("syntax on")
		vim.opt.background = "dark"
		vim.api.nvim_set_var("hybrid_use_term_colors", 1)
		vim.api.nvim_set_var("hybrid_reduced_contrast", 0)

		vim.api.nvim_create_autocmd({ "VimEnter" }, {
			nested = true,
			command = "colorscheme hybrid",
		})
	end,
}
