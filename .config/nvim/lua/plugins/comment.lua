local ok, comment = pcall(require, "Comment")
if not ok then
	return
end

--- Plugin configs.
---@type { config: function, setup: function}
local M = {}

M.config = function()
	comment.setup({
		toggler = {
			line = "<Leader>c",
			block = "<Leader>b",
		},
		opleader = {
			line = "<Leader>c",
			block = "<Leader>b",
		},
	})
end

return M
