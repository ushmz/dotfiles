---Plugin configs.
---@type { config: function, setup: function}
local M = {}

M.config = function()
	vim.api.nvim_set_var("HiSet", "f<CR>")
	vim.api.nvim_set_var("HiErase", "f<BS>")
	vim.api.nvim_set_var("HiClear", "f<C-L>")
	vim.api.nvim_set_var("HiFind", "f<Tab>")
end

return M
