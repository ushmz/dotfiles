-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins/configs", {
	-- concurrency = 6,
	install = { missing = true },
	ui = {
		wrap = false,
		border = "rounded",
		-- icons = {
		-- 	lazy = "󰒲",
		-- },
	},
	change_detection = {
		enabled = true,
		notify = false,
	},
	defaults = {
		lazy = true,
	},
	performance = {
		cache = {
			enabled = true,
		},
		rtp = {
			disabled_plugins = {
				"2html_plugin",
				"getscript",
				"getscriptPlugin",
				"gzip",
				"logiPat",
				"man",
				"matchit",
				"matchparen",
				"netrw",
				"netrwFileHandlers",
				"netrwPlugin",
				"netrwSettings",
				"remote_plugins",
				"rplugin",
				"rrhelper",
				"shada_plugin",
				"shada_plugin",
				"spec",
				"spellfile_plugin",
				"tar",
				"tarPlugin",
				"tutor_mode_plugin",
				"vimball",
				"vimballPlugin",
				"zip",
				"zipPlugin",
			},
		},
	},
})
