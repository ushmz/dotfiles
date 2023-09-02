return {
	"w0ng/vim-hybrid",
	config = function()
		vim.cmd("syntax on")
		vim.opt.background = "dark"
		vim.api.nvim_set_var("hybrid_reduced_contrast", 0)

		vim.api.nvim_create_autocmd({ "VimEnter" }, {
			nested = true,
			callback = function()
				vim.cmd.colorscheme("hybrid")
				-- Going with "mvllow/modes.nvim", I'd like to set this with
				-- 100% of `Normal background` + `line_opacity`% of `Cursor background`
				-- but actually 32% of `Cursor background`
				vim.api.nvim_set_hl(0, "CursorLine", { bg = "#4a4c4d" })
			end,
		})
	end,
}
