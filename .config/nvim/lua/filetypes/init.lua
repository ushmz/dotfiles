-- Add filetype options
vim.filetype.add({
	extension = {
		lock = "yaml",
		zsh = "sh",
	},
	filename = {
		["Brewfile"] = "ruby",
		["go.sum"] = "go",
		["yarn.lock"] = "yaml",
		[".jscsrc"] = "json",
	},
	pattern = {
		[".*/vscode/.*%.json"] = "jsonc",
		["tsconfig.*%.json"] = "jsonc",
		[".*%.js%.map"] = "json",
		["%.config/git/users/.*"] = "gitconfig",
		[".*%.json%.jbuilder"] = "ruby",
		[".*%.conf"] = "conf",
		[".*%.env"] = "env",
		[".*%tmux.conf"] = "tmux",
		[".*%.mdx"] = "jsx",
		[".*%.js%.snap"] = "javascript",
		[".*%.ts%.snap"] = "typescript",
	},
})

-- Set filetype options
local filetype = require("filetypes/filetypes")
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = "*",
	callback = function(args)
		filetype[args.match]()
	end,
})
