local M = {}

M.colors = {
	red = "#CC6666",
	yellow = "#F0C674",
	green = "#B5BD68",
	cyan = "#8aBEB7",
	blue = "#81A2BE",
	purple = "#B294BB",
	gray = "#808080",
	dark_gray = "#26292B",
	black = "#1D1F21",
	white = "#D4D4D4",
	dim = {
		red = "#B87A7A",
		yellow = "#D2BD93",
		green = "#A3A77B",
		cyan = "#91B6B1",
		blue = "#92A2B0",
		purple = "#ADA0B1",
		gray = "#4D4D4D",
		white = "#666666",
	},
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
