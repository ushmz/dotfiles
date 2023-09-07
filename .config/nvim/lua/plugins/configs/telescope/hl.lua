local M = {}

function M.set()
	vim.api.nvim_set_hl(0, "TelescopeMatching", { fg = "#B5BD68", bold = true })
end

return M
