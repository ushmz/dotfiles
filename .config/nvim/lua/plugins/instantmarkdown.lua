--- Plugin configs.
---@type { config: function, setup: function}
local M = {}

M.config = function()
	vim.api.nvim_set_var("instant_markdown_port", 8889)
	vim.keymap.set("n", "<leader>mp", ":<C-u>InstantMarkdownPreview<CR>")
	vim.keymap.set("n", "<leader>ms", ":<C-u>InstantMarkdownStop<CR>")
end

return M
