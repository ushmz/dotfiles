vim.cmd("autocmd!")

-- Set global options
vim.g.loaded_python3_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

vim.g.did_install_default_menus = 1
vim.g.did_install_syntax_menu = 1
vim.g.did_indent_on = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_man = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_remote_plugins = 1
vim.g.loaded_shada_plugin = 1
vim.g.loaded_spellfile_plugin = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.skip_loading_mswin = 1

-- Auto switch IME
vim.api.nvim_create_autocmd({ "InsertLeave", "VimEnter" }, {
	pattern = { "*" },
	callback = function()
		vim.fn.system({ "im-select", "com.apple.keylayout.ABC" })
	end,
})

-- Set options
require("option")

-- Set keymaps
require("mapping")

-- Plugin configs
require("plugin")
