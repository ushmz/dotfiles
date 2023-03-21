-- Add filetype options
vim.filetype.add({
	extension = {
		lock = "yaml",
	},
	filename = {
		Brewfile = "ruby",
		Tmuxfile = "tmux",
		["go.sum"] = "go",
		["yarn.lock"] = "yaml",
		[".jscsrc"] = "json",
	},
	pattern = {
		[".*/vscode/.*%.json"] = "jsonc",
		[".*%.js%.map"] = "json",
		["%.config/git/users/.*"] = "gitconfig",
		[".*%.json%.jbuilder"] = "ruby",
		[".*%.conf"] = "conf",
		[".*%.env%..*"] = "env",
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
