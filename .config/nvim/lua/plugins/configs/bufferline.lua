local function config()
	local colors = require("theme").colors
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
				fg = colors.dim.white,
				bg = colors.dim.gray,
			},
			separator_selected = {
				fg = colors.dim.white,
			},
			background = {
				fg = "#657B83",
				bg = colors.dim.gray,
			},
			buffer_visible = {
				bg = colors.dim.white,
			},
			buffer_selected = {
				fg = "#FDF6E3",
				bg = colors.black,
				italic = false,
			},
			duplicate = {
				bg = colors.dim.gray,
			},
			fill = {
				bg = colors.dim.white,
			},
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
