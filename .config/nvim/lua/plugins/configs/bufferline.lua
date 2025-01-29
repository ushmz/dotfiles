local function config()
	local colors = require("theme").colors

	local text = colors.white
	local active_bg = colors.black

	local subtext = colors.dim.white
	local inactive_bg = colors.light_gray

	local surface = colors.white
	local separator_bg = colors.light_gray
	local bg_highlight = colors.gray

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

			tab_close = { bg = bg_highlight, fg = colors.red },

			indicator_visible = { bg = colors.purple, fg = inactive_bg },
			indicator_selected = { bg = colors.purple, fg = active_bg },

			separator = { bg = inactive_bg, fg = bg_highlight },
			separator_visible = { bg = inactive_bg, fg = bg_highlight },
			separator_selected = { bg = active_bg, fg = bg_highlight },
			offset_separator = { bg = separator_bg, fg = active_bg },

			close_button = { bg = inactive_bg, fg = inactive_bg },
			close_button_visible = { bg = inactive_bg, fg = inactive_bg },
			close_button_selected = { bg = active_bg, fg = colors.red },

			fill = { bg = bg_highlight, fg = bg_highlight },

			numbers = { bg = inactive_bg, fg = subtext },
			numbers_visible = { bg = inactive_bg, fg = subtext },
			numbers_selected = { bg = inactive_bg, fg = text },

			error = { bg = inactive_bg, fg = colors.red },
			error_visible = { bg = inactive_bg, fg = colors.red },
			error_selected = { bg = active_bg, fg = colors.red },
			error_diagnostic = { bg = inactive_bg, fg = colors.red },
			error_diagnostic_visible = { bg = inactive_bg, fg = colors.red },
			error_diagnostic_selected = { bg = active_bg, fg = colors.red },

			warning = { bg = inactive_bg, fg = colors.yellow },
			warning_visible = { bg = inactive_bg, fg = colors.yellow },
			warning_selected = { bg = active_bg, fg = colors.yellow },
			warning_diagnostic = { bg = inactive_bg, fg = colors.yellow },
			warning_diagnostic_visible = { bg = inactive_bg, fg = colors.yellow },
			warning_diagnostic_selected = { bg = active_bg, fg = colors.yellow },

			info = { bg = inactive_bg, fg = colors.green },
			info_visible = { bg = inactive_bg, fg = colors.green },
			info_selected = { bg = active_bg, fg = colors.green },
			info_diagnostic = { bg = inactive_bg, fg = colors.green },
			info_diagnostic_visible = { bg = inactive_bg, fg = colors.green },
			info_diagnostic_selected = { bg = active_bg, fg = colors.green },

			hint = { bg = inactive_bg, fg = colors.blue },
			hint_visible = { bg = inactive_bg, fg = colors.blue },
			hint_selected = { bg = active_bg, fg = colors.blue },
			hint_diagnostic = { bg = inactive_bg, fg = colors.blue },
			hint_diagnostic_visible = { bg = inactive_bg, fg = colors.blue },
			hint_diagnostic_selected = { bg = active_bg, fg = colors.blue },

			diagnostic = { bg = inactive_bg, fg = subtext },
			diagnostic_visible = { bg = inactive_bg, fg = subtext },
			diagnostic_selected = { bg = active_bg, fg = text },

			modified = { bg = inactive_bg, fg = colors.green },
			modified_visible = { bg = inactive_bg, fg = colors.green },
			modified_selected = { bg = active_bg, fg = colors.green },
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
