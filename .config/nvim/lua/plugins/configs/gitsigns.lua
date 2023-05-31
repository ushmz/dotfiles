local function config()
	require("gitsigns").setup({
		signs = {
			add = { text = "│" },
			change = { text = "│" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
			untracked = { text = "┆" },
		},
		signcolumn = true,
		numhl = false,
		linehl = false,
		word_diff = false,
		watch_gitdir = {
			interval = 1000,
			follow_files = true,
		},
		attach_to_untracked = true,
		current_line_blame = true,
		current_line_blame_opts = {
			virt_text = true,
			virt_text_pos = "eol",
			delay = 1000,
			ignore_whitespace = false,
		},
		current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
		sign_priority = 6,
		update_debounce = 100,
		status_formatter = nil,
		max_file_length = 40000, -- in lines
		preview_config = {
			-- Options passed to nvim_open_win
			border = "single",
			style = "minimal",
			relative = "cursor",
			row = 0,
			col = 1,
		},
		yadm = {
			enable = false,
		},
		on_attach = function(bufnr)
			local signs = require("gitsigns")
			vim.keymap.set("n", "<leader>bl", function()
				signs.blame_line({ full = true })
			end, { buffer = bufnr })
			vim.keymap.set("n", "<leader>tb", signs.toggle_current_line_blame, { buffer = bufnr })
		end,
	})
end

return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre" },
	config = config,
}
