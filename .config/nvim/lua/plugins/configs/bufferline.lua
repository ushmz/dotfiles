local function config()
	local colors = require("kanagawa.colors").setup({ theme = "dragon" })

	local text = colors.palette.dragonWhite
	local active_bg = colors.palette.dragonBlack0

	local subtext = colors.palette.dragonGray2
	local inactive_bg = colors.palette.dragonGray

	local surface = colors.palette.dragonWhite
	local separator_bg = colors.palette.dragonGray
	local bg_highlight = colors.palette.dragonGray3

	require("bufferline").setup({
		options = {
			mode = "tabs",
			separator_style = "slant",
			diagnostics = "nvim_lsp",
			diagnostics_indicator = function(count)
				return "(" .. count .. ")"
			end,
			always_show_bufferline = true,
			show_buffer_close_icons = true,
			show_close_icon = false,
			color_icons = true,
		},
		highlights = {
			background = { bg = inactive_bg, fg = subtext },
			buffer_visible = { bg = inactive_bg, fg = subtext },
			buffer_selected = { bg = active_bg, fg = text },

			duplicate = { bg = inactive_bg, fg = subtext },
			duplicate_visible = { bg = inactive_bg, fg = subtext },
			duplicate_selected = { bg = active_bg, fg = surface },

			tab = { bg = inactive_bg, fg = surface },
			tab_selected = { bg = inactive_bg, fg = active_bg },

			tab_separator = { bg = separator_bg, fg = inactive_bg },
			tab_separator_selected = { bg = separator_bg, fg = active_bg },

			tab_close = { bg = bg_highlight, fg = colors.palette.dragonRed },

			indicator_visible = { bg = colors.palette.dragonViolet, fg = inactive_bg },
			indicator_selected = { bg = colors.palette.dragonViolet, fg = active_bg },

			separator = { bg = inactive_bg, fg = bg_highlight },
			separator_visible = { bg = inactive_bg, fg = bg_highlight },
			separator_selected = { bg = active_bg, fg = bg_highlight },
			offset_separator = { bg = separator_bg, fg = active_bg },

			close_button = { bg = inactive_bg, fg = inactive_bg },
			close_button_visible = { bg = inactive_bg, fg = inactive_bg },
			close_button_selected = { bg = active_bg, fg = colors.palette.dragonRed },

			fill = { bg = bg_highlight, fg = bg_highlight },

			numbers = { bg = inactive_bg, fg = subtext },
			numbers_visible = { bg = inactive_bg, fg = subtext },
			numbers_selected = { bg = inactive_bg, fg = text },

			error = { bg = inactive_bg, fg = colors.palette.dragonRed },
			error_visible = { bg = inactive_bg, fg = colors.palette.dragonRed },
			error_selected = { bg = active_bg, fg = colors.palette.dragonRed },
			error_diagnostic = { bg = inactive_bg, fg = colors.palette.dragonRed },
			error_diagnostic_visible = { bg = inactive_bg, fg = colors.palette.dragonRed },
			error_diagnostic_selected = { bg = active_bg, fg = colors.palette.dragonRed },

			warning = { bg = inactive_bg, fg = colors.palette.dragonYellow },
			warning_visible = { bg = inactive_bg, fg = colors.palette.dragonYellow },
			warning_selected = { bg = active_bg, fg = colors.palette.dragonYellow },
			warning_diagnostic = { bg = inactive_bg, fg = colors.palette.dragonYellow },
			warning_diagnostic_visible = { bg = inactive_bg, fg = colors.palette.dragonYellow },
			warning_diagnostic_selected = { bg = active_bg, fg = colors.palette.dragonYellow },

			info = { bg = inactive_bg, fg = colors.palette.dragonGreen2 },
			info_visible = { bg = inactive_bg, fg = colors.palette.dragonGreen2 },
			info_selected = { bg = active_bg, fg = colors.palette.dragonGreen2 },
			info_diagnostic = { bg = inactive_bg, fg = colors.palette.dragonGreen2 },
			info_diagnostic_visible = { bg = inactive_bg, fg = colors.palette.dragonGreen2 },
			info_diagnostic_selected = { bg = active_bg, fg = colors.palette.dragonGreen2 },

			hint = { bg = inactive_bg, fg = colors.palette.dragonBlue },
			hint_visible = { bg = inactive_bg, fg = colors.palette.dragonBlue },
			hint_selected = { bg = active_bg, fg = colors.palette.dragonBlue },
			hint_diagnostic = { bg = inactive_bg, fg = colors.palette.dragonBlue },
			hint_diagnostic_visible = { bg = inactive_bg, fg = colors.palette.dragonBlue },
			hint_diagnostic_selected = { bg = active_bg, fg = colors.palette.dragonBlue },

			diagnostic = { bg = inactive_bg, fg = subtext },
			diagnostic_visible = { bg = inactive_bg, fg = subtext },
			diagnostic_selected = { bg = active_bg, fg = text },

			modified = { bg = inactive_bg, fg = colors.palette.dragonGreen2 },
			modified_visible = { bg = inactive_bg, fg = colors.palette.dragonGreen2 },
			modified_selected = { bg = active_bg, fg = colors.palette.dragonGreen2 },
		},
	})

	vim.keymap.set("n", "<C-w>]", "<Cmd>BufferLineCycleNext<CR>", { silent = true })
	vim.keymap.set("n", "<C-w>[", "<Cmd>BufferLineCyclePrev<CR>", { silent = true })
end

return {
	"akinsho/bufferline.nvim",
	event = { "VeryLazy" },
	config = config,
}
