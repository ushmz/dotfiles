return {
	"rebelot/kanagawa.nvim",
	lazy = false,
	config = function()
		require("kanagawa").setup({
			compile = true,
			undercurl = false,
			commentStyle = { italic = false },
			functionStyle = {},
			keywordStyle = { italic = false },
			statementStyle = { bold = true },
			typeStyle = {},
			transparent = false,
			dimInactive = true,
			terminalColors = true,
			colors = {
				palette = {},
				theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
			},
			overrides = function(colors)
				local theme = colors.theme
				return {
					-- Borderless Telescope
					-- TelescopeTitle = { fg = theme.ui.special, bold = true },
					-- TelescopePromptNormal = { bg = theme.ui.bg_p1 },
					-- TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
					-- TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
					-- TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
					-- TelescopePreviewNormal = { bg = theme.ui.bg_dim },
					-- TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
					-- Dark completion (popup) menu
					Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1, blend = vim.o.pumblend },
					PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
					PmenuSbar = { bg = theme.ui.bg_m1 },
					PmenuThumb = { bg = theme.ui.bg_p2 },
				}
			end,
			theme = "dragon",
			background = {
				dark = "dragon",
				light = "lotus",
			},
		})

		vim.api.nvim_create_autocmd("ColorScheme", {
			pattern = "kanagawa",
			callback = function()
				if vim.o.background == "light" then
					vim.fn.system("kitty +kitten themes Kanagawa_light")
				elseif vim.o.background == "dark" then
					vim.fn.system("kitty +kitten themes Kanagawa_dragon")
				else
					vim.fn.system("kitty +kitten themes Kanagawa")
				end
			end,
		})
		vim.cmd("colorscheme kanagawa")
	end,
}
