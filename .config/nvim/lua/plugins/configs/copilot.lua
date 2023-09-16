local function config()
	vim.g.copilot_no_tab_map = true
	local key = vim.keymap.set
	local opt = { silent = true, expr = true, script = true, replace_keycodes = false }

	key("i", "<C-g><CR>", 'copilot#Accept("")', opt)
	key("i", "<C-j>", "<Plug>(copilot-next)")
	key("i", "<C-k>", "<Plug>(copilot-previous)")
	key("i", "<C-o>", "<Plug>(copilot-dismiss)")
	key("i", "<C-s>", "<Plug>(copilot-suggest)")
end

return {
	"github/copilot.vim",
	cond = function()
		return vim.env.USER ~= "ushmz"
	end,
	config = config,
	event = { "InsertEnter" },
}
