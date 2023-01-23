vim.cmd("autocmd!")

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

-- filetype
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "javascriptreact", "typescriptreact", "dart", "lua", "vim" },
	command = "set tabstop=2 shiftwidth=2 softtabstop=2",
})

require("options")
require("mappings")
require("plugins")
