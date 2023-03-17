vim.cmd("autocmd!")

-- Auto switch IME
vim.api.nvim_create_autocmd({ "InsertLeave", "VimEnter" }, {
	pattern = { "*" },
	callback = function()
		vim.fn.system({ "im-select", "com.apple.keylayout.ABC" })
	end,
})

-- Set options
require("basics")

-- Set filetype options
require("filetypes")

-- Set keymaps
require("mappings")

-- Plugin configs
require("plugins")
