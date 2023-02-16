local ok, blankline = pcall(require, "indent_blankline")
if not ok then
	return
end

---Plugin configs.
---@type { config: function, setup: function}
local M = {}

M.config = function()
	vim.opt.list = true
	-- vim.opt.listchars:append "space:⋅"
	vim.opt.listchars:append("eol:↴")

	blankline.setup({
		show_end_of_line = true,
		space_char_blankline = " ",
		show_current_context = true,
		show_current_context_start = true,
	})
end

return M
