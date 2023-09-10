local function config()
	require("smart-splits").setup({
		ignored_filetypes = {
			"nofile",
			"quickfix",
			"prompt",
		},
		ignored_buftypes = {
			"NvimTree",
			"TelescopePrompt",
		},
		default_amount = 3,
		at_edge = "stop",
		move_cursor_same_row = false,
		cursor_follows_swapped_bufs = false,
		resize_mode = {
			quit_key = "<ESC>",
			-- keys to use for moving in resize mode in order of left, down, up' right
			resize_keys = { "h", "j", "k", "l" },
			silent = true,
			hooks = {
				on_enter = nil,
				on_leave = nil,
			},
		},
		ignored_events = {
			"BufEnter",
			"WinEnter",
		},
		multiplexer_integration = nil,
		disable_multiplexer_nav_when_zoomed = true,
		kitty_password = nil,
		log_level = "info",
	})

	-- resizing splits (these keymaps will also accept a range)
	vim.keymap.set("n", "<Left>", require("smart-splits").resize_left)
	vim.keymap.set("n", "<Down>", require("smart-splits").resize_down)
	vim.keymap.set("n", "<Up>", require("smart-splits").resize_up)
	vim.keymap.set("n", "<Right>", require("smart-splits").resize_right)
	-- moving between splits
	vim.keymap.set("n", "<C-w>h", require("smart-splits").move_cursor_left)
	vim.keymap.set("n", "<C-w>j", require("smart-splits").move_cursor_down)
	vim.keymap.set("n", "<C-w>k", require("smart-splits").move_cursor_up)
	vim.keymap.set("n", "<C-w>l", require("smart-splits").move_cursor_right)
	-- swapping buffers between windows
	vim.keymap.set("n", "<C-w>H", require("smart-splits").swap_buf_left)
	vim.keymap.set("n", "<C-w>J", require("smart-splits").swap_buf_down)
	vim.keymap.set("n", "<C-w>K", require("smart-splits").swap_buf_up)
	vim.keymap.set("n", "<C-w>L", require("smart-splits").swap_buf_right)
end

return {
	"mrjones2014/smart-splits.nvim",
	event = "BufRead",
	config = config,
}
