local ok, autotag = pcall(require, "nvim-ts-autotag")
if not ok then
	return
end

--- Plugin configs.
---@type { config: function, setup: function}
local M = {}

M.config = function()
	autotag.setup({})
end

return M
