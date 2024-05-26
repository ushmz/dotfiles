local M = {}

---Return `true` if the plugin should be loaded, otherwise `false`
---@param for_vscode boolean The plugin is needed for VSCode or not
---@return boolean
M.should_loaded = function(for_vscode)
	if not vim.g.vscode then
		return true
	end
	return for_vscode
end

M.flatten = function(tbl)
	return vim.iter(tbl):flatten():totable()
end

return M
