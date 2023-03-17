local function config()
	require("bufferline").setup({
		options = {
			mode = "tabs",
			separator_style = "slant",
			always_show_bufferline = true,
			show_buffer_close_icons = false,
			show_close_icon = false,
			color_icons = true,
		},
		highlights = {
			separator = {
				fg = "#4E4E4E",
				bg = "#2D2F31",
			},
			separator_selected = {
				fg = "#4E4E4E",
			},
			background = {
				fg = "#657B83",
				bg = "#2D2F31",
			},
			buffer_selected = {
				fg = "#FDF6E3",
				italic = false,
			},
			fill = {
				bg = "#4E4E4E",
			},
		},
	})

	vim.keymap.set("n", "<leader>]", "<Cmd>BufferLineCycleNext<CR>", { silent = true })
	vim.keymap.set("n", "<leader>[", "<Cmd>BufferLineCyclePrev<CR>", { silent = true })
end

return {
	"akinsho/bufferline.nvim",
	event = { "BufRead" },
	config = config,
}
