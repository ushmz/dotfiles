vim.cmd("autocmd!")

-- Set global options
vim.g.loaded_python3_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

vim.g.loaded_gzip = 1
vim.g.loaded_man = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_shada_plugin = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_tar = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_netrwPlugin = 1

-- Setup autocmd
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	pattern = { "plugins.lua" },
	command = "PackerCompile",
})

-- Auto switch IME
vim.api.nvim_create_autocmd({ "InsertLeave", "VimEnter" }, {
	pattern = { "*" },
	callback = function()
		vim.fn.system({ "im-select", "com.apple.keylayout.ABC" })
	end,
})

vim.api.nvim_create_autocmd({ "BufNewFile" }, {
	pattern = { "*.sh" },
	command = "0r ~/.config/nvim/templates/skeleton.sh",
})

-- Set filetype options
local filetype = require("filetype")
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = "*",
	callback = function(args)
		filetype[args.match]()
	end,
})

-- Set options
require("option")

-- Set keymaps
require("mapping")

-- Plugin configs
require("plugin")
