local ok, fidget = pcall(require, "fidget")
if not ok then
	return
end

local M = {}

M.config = function ()
	fidget.setup({})
end

return M
