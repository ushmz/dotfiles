local ok, icons = pcall(require, "nvim-web-devicons")
if not ok then
	return
end

--- Plugin configs.
---@type { config: function, setup: function}
local M = {}

M.config = function()
	icons.setup({
		-- your personnal icons can go here (to override)
		-- DevIcon will be appended to `name`
		override = {},
		-- globally enable default icons (default to false)
		-- will get overriden by `get_icons` option
		default = true,
	})
end

return M
