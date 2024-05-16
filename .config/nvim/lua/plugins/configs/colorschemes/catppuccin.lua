local setup = function()
	require("catppuccin").setup({
		compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
		flavour = "frappe",
		background = {
			light = "latte",
			dark = "frappe",
		},
		term_colors = true,
		dim_inactive = {
			enabled = true,
			shade = "dark",
			percentage = 0.01,
		},
		no_italic = true,
		no_bold = true,
		no_underline = true,
		custom_highlights = function()
			return {
				Normal = { bg = "#1D1F21" },
				NormalNC = { bg = "#26292B" },
				SignColumn = { bg = nil },
				LineNR = { fg = "#666666", bg = nil },
				CursorLine = { bg = "#4A4C4D" },
			}
		end,
		integrations = {
			cmp = true,
			dap = true,
			dap_ui = true,
			gitsigns = true,
			harpoon = true,
			indent_blankline = {
				enabled = true,
				scope_color = "", -- catppuccin color (eg. `lavender`) Default: text
				colored_indent_levels = false,
			},
			lsp_saga = true,
			markdown = true,
			mason = true,
			native_lsp = {
				enabled = true,
				inlay_hints = {
					background = true,
				},
			},
			neotest = true,
			semantic_tokens = true,
			treesitter = true,
			treesitter_context = true,
			-- ts_rainbow2 = true,
			octo = true,
			telescope = {
				enabled = true,
			},
			lsp_trouble = true,
			illuminate = {
				enabled = true,
				lsp = false,
			},
			notify = false,
			mini = {
				enabled = true,
				indentscope_color = "",
			},
		},
	})
end

return {
	"catppuccin/nvim",
	cond = false,
	name = "catppuccin",
	config = function()
		vim.cmd("syntax on")
		vim.opt.background = "dark"

		setup()
		vim.api.nvim_create_autocmd({ "VimEnter" }, {
			nested = true,
			callback = function()
				vim.cmd.colorscheme("catppuccin")
			end,
		})
	end,
}
