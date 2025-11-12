local config = function()
	require("copilot").setup({
		panel = {
			enabled = true,
			auto_refresh = false,
			keymap = {
				jump_prev = "[[",
				jump_next = "]]",
				accept = "<CR>",
				refresh = "gr",
				open = "<M-CR>",
			},
			layout = {
				position = "bottom", -- | top | left | right | horizontal | vertical
				ratio = 0.4,
			},
		},
		suggestion = {
			enabled = true,
			auto_trigger = true,
			hide_during_completion = true,
			debounce = 75,
			keymap = {
				accept = "<C-g><CR>",
				accept_word = "<C-g>w",
				accept_line = "<C-g>l",
				next = "<C-g><C-n>",
				prev = "<C-g><C-p>",
				dismiss = "<C-g>e",
			},
		},
		filetypes = {
			yaml = false,
			markdown = false,
			help = false,
			gitcommit = true,
			gitrebase = false,
			hgcommit = false,
			svn = false,
			csv = false,
		},
		copilot_node_command = "node", -- Node.js version must be > 18.x
		server_opts_overrides = {},
		nes = {
			enabled = false,
			keymap = {
				accept = "<C-g>a",
				accept_word = false,
				accept_line = false,
				dismiss = "<ESC>",
			},
		},
	})
end

return {
	"zbirenbaum/copilot.lua",
	dependencies = {
		"copilotlsp-nvim/copilot-lsp",
		init = function()
			vim.g.copilot_nes_debounce = 500
		end,
	},
	cmd = "Copilot",
	event = "InsertEnter",
	config = config,
}
