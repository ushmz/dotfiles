local ok, autopairs = pcall(require, "nvim-autopairs")
if not ok then
	return
end

--- Plugin configs.
---@type { config: function, setup: function}
local M = {}

M.config = function()
	autopairs.setup({
		disable_filetype = { "TelescopePrompt", "vim" },
	})
end

return M
