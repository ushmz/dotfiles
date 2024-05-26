return {
	{
		"w0ng/vim-hybrid",
		lazy = false,
		config = function()
			vim.cmd("syntax on")
			vim.opt.background = "dark"
			vim.api.nvim_set_var("hybrid_reduced_contrast", 0)

			local colors = require("theme").colors

			vim.api.nvim_create_autocmd({ "VimEnter" }, {
				nested = true,
				callback = function()
					vim.cmd.colorscheme("hybrid")
					vim.api.nvim_set_hl(0, "Normal", { bg = colors.black })
					vim.api.nvim_set_hl(0, "NormalNC", { bg = colors.dark_gray })
					vim.api.nvim_set_hl(0, "SignColumn", { bg = nil })
					vim.api.nvim_set_hl(0, "LineNR", { fg = colors.dim.white, bg = nil })
					vim.api.nvim_set_hl(0, "CursorLine", { bg = colors.dim.gray })
					vim.api.nvim_set_hl(0, "@variable", { fg = colors.purple })
					vim.api.nvim_set_hl(0, "@punctuation.bracket", { fg = colors.green })
				end,
			})
		end,
	},
}
