local ok, fidget = pcall(require, "fidget")
if not ok then
	return
end

--- Plugin configs.
---@type { config: function, setup: function}
local M = {}

M.config = function()
	fidget.setup({})
end

return M
