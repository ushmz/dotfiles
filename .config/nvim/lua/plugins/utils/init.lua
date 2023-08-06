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

M.theme = {
	red = "#CC6666",
	yellow = "#F0C674",
	green = "#B5BD68",
	cyan = "#8aBEB7",
	blue = "#81A2BE",
	purple = "#B294BB",
	gray = "#808080",
	white = "#D4D4D4",
	black = "#1D1F21",
	---If you'd like to use mode rich colors,
	---please refer following palette.
	-- magenta = "#B5585F",
	-- pink = "#C586C0",
	-- orange = "#DE935F",
	-- dark_yellow = "#D4BB6C",
	-- emerald = "#58B5A8",
	-- cobalt = "#6C8ED4",
	-- light_blue = "#9CDCFE",
	-- dark_gray = "#282A2E",
	-- light_gray = "#C5C8C6",
}

---Sets a highlight with `vim.api.nvim_set_hl()`
---@param name string Highlight group name
---@param val table Highlight definition map
M.set_hl = function(name, val)
	vim.api.nvim_set_hl(0, name, val)
end

return M
