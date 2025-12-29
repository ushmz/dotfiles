local M = {}

M.setup = function()
	local select = require("nvim-treesitter-textobjects.select")
	local mode = { "x", "o" }

	-- function
	vim.keymap.set(mode, "af", function()
		select.select_textobject("@function.outer", "textobjects")
	end)
	vim.keymap.set(mode, "if", function()
		select.select_textobject("@function.inner", "textobjects")
	end)

	-- comment
	vim.keymap.set(mode, "ac", function()
		select.select_textobject("@comment.outer", "textobjects")
	end)

	-- class
	vim.keymap.set(mode, "aC", function()
		select.select_textobject("@class.outer", "textobjects")
	end)
	vim.keymap.set(mode, "iC", function()
		select.select_textobject("@class.inner", "textobjects")
	end)

	-- block
	vim.keymap.set(mode, "ab", function()
		select.select_textobject("@block.outer", "textobjects")
	end)
	vim.keymap.set(mode, "ib", function()
		select.select_textobject("@block.inner", "textobjects")
	end)

	-- conditional
	vim.keymap.set(mode, "ad", function()
		select.select_textobject("@conditional.outer", "textobjects")
	end)
	vim.keymap.set(mode, "id", function()
		select.select_textobject("@conditional.inner", "textobjects")
	end)

	-- loop
	vim.keymap.set(mode, "ao", function()
		select.select_textobject("@loop.outer", "textobjects")
	end)
	vim.keymap.set(mode, "io", function()
		select.select_textobject("@loop.inner", "textobjects")
	end)

	-- statement
	vim.keymap.set(mode, "as", function()
		select.select_textobject("@statement.outer", "textobjects")
	end)
	vim.keymap.set(mode, "is", function()
		select.select_textobject("@statement.outer", "textobjects")
	end)
end

return M
