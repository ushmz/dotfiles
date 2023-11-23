return {
	"w0ng/vim-hybrid",
	lazy = false,
	config = function()
		vim.cmd("syntax on")
		vim.opt.background = "dark"
		vim.api.nvim_set_var("hybrid_reduced_contrast", 0)

		vim.api.nvim_create_autocmd({ "VimEnter" }, {
			nested = true,
			callback = function()
				vim.cmd.colorscheme("hybrid")
				vim.api.nvim_set_hl(0, "Normal", { bg = "#1D1F21" })
				vim.api.nvim_set_hl(0, "NormalNC", { bg = "#26292B" })
				vim.api.nvim_set_hl(0, "SignColumn", { bg = nil })
				vim.api.nvim_set_hl(0, "LineNR", { fg = "#666666", bg = nil })
				vim.api.nvim_set_hl(0, "CursorLine", { bg = "#4A4C4D" })
			end,
		})
	end,
}
