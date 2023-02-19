local ok, colorizer = pcall(require, "colorizer")
if not ok then
	return
end

--- Plugin configs.
---@type { config: function, setup: function}
local M = {}

M.config = function()
	colorizer.setup({
		"*",
		css = { css = true, RRGGBBAA = true },
		html = { names = false },
	})
end

return M
