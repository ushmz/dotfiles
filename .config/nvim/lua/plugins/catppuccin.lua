local ok, catppuccin = pcall(require, "catppuccin")
if not ok then
	return
end

--- Plugin configs.
---@type { config: function, setup: function}
local M = {}

M.config = function()
	catppuccin.setup({
		flavour = "macchiato", -- latte, frappe, macchiato, mocha
		background = {
			light = "latte",
			dark = "mocha",
		},
		transparent_background = true,
		show_end_of_buffer = false, -- show the '~' characters after the end of buffers
		term_colors = true,
		dim_inactive = {
			enabled = false,
			shade = "dark",
			percentage = 0.15,
		},
		no_italic = false,
		no_bold = false,
		styles = {
			comments = {},
			conditionals = {},
			loops = {},
			functions = {},
			keywords = {},
			strings = {},
			variables = {},
			numbers = {},
			booleans = {},
			properties = {},
			types = {},
			operators = {},
		},
		color_overrides = {},
		custom_highlights = {},
		integrations = {
			cmp = true,
			gitsigns = true,
			lsp_saga = true,
			mason = true,
			telescope = true,
			treesitter = true,
			treesitter_context = true,
			-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
		},
	})

	-- setup must be called before loading
	vim.cmd.colorscheme("catppuccin")
end

return M
