local function config()
	local theme = require("plugins.utils").theme
	require("bufferline").setup({
		options = {
			mode = "tabs",
			separator_style = "slant",
			always_show_bufferline = true,
			show_buffer_close_icons = false,
			show_close_icon = false,
			color_icons = true,
		},
		---If you'd like to integrate with colorscheme `catppuccin`, add following
		---```
		---highlights = require("catppuccin.groups.integrations.bufferline").get()
		---```
		highlights = {
			separator = {
				fg = theme.dim.white,
				bg = theme.dim.gray,
			},
			separator_selected = {
				fg = theme.dim.white,
			},
			background = {
				fg = "#657B83",
				bg = theme.dim.gray,
			},
			buffer_visible = {
				bg = theme.dim.white,
			},
			buffer_selected = {
				fg = "#FDF6E3",
				bg = theme.black,
				italic = false,
			},
			duplicate = {
				bg = theme.dim.gray,
			},
			fill = {
				bg = theme.dim.white,
			},
		},
	})

	vim.keymap.set("n", "<leader>]", "<Cmd>BufferLineCycleNext<CR>", { silent = true })
	vim.keymap.set("n", "<leader>[", "<Cmd>BufferLineCyclePrev<CR>", { silent = true })
end

return {
	"akinsho/bufferline.nvim",
	event = { "WinNew" },
	config = config,
}
