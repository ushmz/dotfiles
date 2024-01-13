-- Add filetype options
vim.filetype.add({
	extension = {
		jsonc = "json",
	},
	filename = {
		Brewfile = "ruby",
		-- Tmuxfile = "tmux",
		["go.sum"] = "go",
	},
	pattern = {
		[".*/vscode/.*%.json"] = "jsonc",
		["tsconfig.*%.json"] = "jsonc",
		[".*%.js%.map"] = "json",
		["%.config/git/users/.*"] = "gitconfig",
		[".*%.json%.jbuilder"] = "ruby",
		[".*%.conf"] = "conf",
		[".*%.env%..*"] = "env",
		[".*%tmux.conf"] = "tmux",
		[".*%.zsh"] = "zsh",
		[".*%.mdx"] = "jsx",
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
