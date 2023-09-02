local function config()
	require("git-conflict").setup({
		default_mappings = false,
		default_commands = true,
		disable_diagnostics = false,
		highlights = {
			incomming = "DiffAdd",
			current = "DiffText",
		},
	})

	local key = vim.keymap.set
	key("n", "<C-g>o", "<Plug>(git-conflict-ours)", { desc = "Git conflict Choose [O]urs" })
	key("n", "<C-g>t", "<Plug>(git-conflict-theirs)", { desc = "Git conflict Choose [T]heirs" })
	key("n", "<C-g>b", "<Plug>(git-conflict-both)", { desc = "Git conflict Choose [B]oth" })
	key("n", "<C-g>n", "<Plug>(git-conflict-none)", { desc = "Git conflict Choose [N]one" })
	key("n", "<C-g>[", "<Plug>(git-conflict-prev-conflict)", { desc = "Git conflict Go to previous conflict" })
	key("n", "<C-g>]", "<Plug>(git-conflict-next-conflict)", { desc = "Git conflict Go to next conflict" })

	local theme = require("plugins.utils").theme
	local set_hl = require("plugins.utils").set_hl
	set_hl("DiffAdd", { bg = theme.green, fg = nil, blend = 30 })
	set_hl("DiffChange", { bg = theme.gray, fg = theme.white, blend = 30 })
	set_hl("DiffDelete", { bg = theme.red, fg = nil, blend = 30 })
	set_hl("DiffText", { bg = nil, fg = nil })
end

return {
	---@see https://github.com/akinsho/git-conflict.nvim/issues/14
	---You shouldn't lazy load this plugin.
	"akinsho/git-conflict.nvim",
	version = "1.1.2",
	config = config,
}
