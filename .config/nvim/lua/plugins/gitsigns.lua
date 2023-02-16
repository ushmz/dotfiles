---Plugin configs.
---@type { config: function, setup: function}
local M = {}

M.config = function()
	require("gitsigns").setup({})
end

return M
