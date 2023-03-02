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
		[".*%.js%.map"] = "json",
		["%.config/git/users/.*"] = "gitconfig",
		[".*%.json%.jbuilder"] = "ruby",
		[".*%.conf"] = "conf",
		[".*%.env%..*"] = "env",
	},
})
