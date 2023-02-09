vim.filetype.add({
	filename = {
		Brewfile = "ruby",
		Tmuxfile = "tmux",
		["go.sum"] = "go",
		["yarn.lock"] = "yaml",
		[".jscsrc"] = "json",
	},
	pattern = {
		[".*%.js%.map"] = "json",
		[".*%.postman_collection"] = "json",
		["%.config/git/users/.*"] = "gitconfig",
		[".*%.json%.jbuilder"] = "ruby",
	},
})
