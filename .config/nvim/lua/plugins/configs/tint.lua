return {
	"levouh/tint.nvim",
	event = { "BufRead" },
	config = function()
		require("tint").setup({
			tint = -60,
			saturation = 0.4,
			highlight_ignore_patterns = {
				"WinSeparator",
				"Status.*",
				"Rainbow*",
			},
			window_ignore_function = function(win_id)
				local buf_id = vim.api.nvim_win_get_buf(win_id)
				local buftype = vim.api.nvim_buf_get_option(buf_id, "buftype")
				local filetype = vim.api.nvim_buf_get_option(buf_id, "filetype")
				local floating = vim.api.nvim_win_get_config(win_id).relative ~= ""

				return buftype == "terminal" or filetype == "TelescopePrompt" or floating
			end,
		})
	end,
}
