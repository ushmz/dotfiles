local M = {}

M.setup = function()
	local swap = require("nvim-treesitter-textobjects.swap")

	vim.keymap.set("n", ")f", function()
		swap.swap_next("@function.outer")
	end)

	vim.keymap.set("n", ")c", function()
		swap.swap_next("@comment.outer")
	end)
	vim.keymap.set("n", ")a", function()
		swap.swap_next("@parameter.inner")
	end)
	vim.keymap.set("n", ")b", function()
		swap.swap_next("@block.outer")
	end)
	vim.keymap.set("n", ")C", function()
		swap.swap_next("@class.outer")
	end)

	vim.keymap.set("n", "(f", function()
		swap.swap_previous("@function.outer")
	end)
	vim.keymap.set("n", "(c", function()
		swap.swap_previous("@comment.outer")
	end)
	vim.keymap.set("n", "(a", function()
		swap.swap_previous("@parameter.inner")
	end)
	vim.keymap.set("n", "(b", function()
		swap.swap_previous("@block.outer")
	end)
	vim.keymap.set("n", "(C", function()
		swap.swap_previous("@class.outer")
	end)
end

return M
