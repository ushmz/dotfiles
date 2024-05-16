return {
	{
		"w0ng/vim-hybrid",
		lazy = false,
		config = function()
			vim.cmd("syntax on")
			vim.opt.background = "dark"
			vim.api.nvim_set_var("hybrid_reduced_contrast", 0)

			local theme = require("plugins.utils").theme

			vim.api.nvim_create_autocmd({ "VimEnter" }, {
				nested = true,
				callback = function()
					vim.cmd.colorscheme("hybrid")
					vim.api.nvim_set_hl(0, "Normal", { bg = theme.black })
					vim.api.nvim_set_hl(0, "NormalNC", { bg = theme.dark_gray })
					vim.api.nvim_set_hl(0, "SignColumn", { bg = nil })
					vim.api.nvim_set_hl(0, "LineNR", { fg = theme.dim.white, bg = nil })
					vim.api.nvim_set_hl(0, "CursorLine", { bg = theme.dim.gray })
					vim.api.nvim_set_hl(0, "@variable", { fg = theme.purple })
					vim.api.nvim_set_hl(0, "@punctuation.bracket", { fg = theme.green })
				end,
			})
		end,
	},
}
