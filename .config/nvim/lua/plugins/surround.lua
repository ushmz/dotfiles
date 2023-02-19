local ok, surround = pcall(require, "nvim-surround")
if not ok then
	return
end

--- Plugin configs.
---@type { config: function, setup: function}
local M = {}

M.config = function()
	surround.setup()
end

return M
