local M = {}

M.set = function()
	vim.api.nvim_set_hl(0, "TelescopeMatching", { fg = "#B5BD68", bold = true })
end

return M
