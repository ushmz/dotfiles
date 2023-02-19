local ok, gitsigns = pcall(require, "gitsigns")
if not ok then
	return
end

--- Plugin configs.
---@type { config: function, setup: function}
local M = {}

M.config = function()
	gitsigns.setup({})
end

return M
