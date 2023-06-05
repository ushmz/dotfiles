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
end

return {
	---@see https://github.com/akinsho/git-conflict.nvim/issues/14
	---You shouldn't lazy load this plugin.
	"akinsho/git-conflict.nvim",
	version = "1.1.2",
	config = config,
}
