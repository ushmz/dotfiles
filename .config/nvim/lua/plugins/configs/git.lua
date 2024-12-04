local function config()
	require("git").setup({
		keymaps = {
			-- Open blame window
			blame = "<C-g>b",
			-- Close blame window
			quit_blame = "q",
			-- Open blame commit
			blame_commit = "<CR>",
			-- Open file/folder in git repository
			browse = "<C-g>v",
			-- Open pull request of the current branch
			open_pull_request = "<C-g>P",
			-- Create a pull request with the target branch
			-- is set in the `target_branch` option
			create_pull_request = "<C-g>p",
			-- Opens a new diff that compares against the current index
			diff = "<C-g>d",
			-- Close git diff
			diff_close = "q",
			-- Revert to the specific commit
			revert = "<C-g>r",
			-- Revert the current file to the specific commit
			revert_file = "<C-g>R",
		},
	})
end

return {
	"dinhhuy258/git.nvim",
	keys = {
		{ "<C-g>b", mode = { "n", "v" }, desc = "git: Open [b]lame window" },
		{ "<C-g>v", mode = { "n", "v" }, desc = "git: [v]iew file/folder in git repository" },
		{ "<C-g>P", mode = { "n", "v" }, desc = "git: Open pull request of the current branch" },
		{ "<C-g>p", mode = { "n", "v" }, desc = "git: Create a [p]ull request with the target branch" },
		{ "<C-g>d", mode = { "n", "v" }, desc = "git: Opens a new [d]iff that compares against the current index" },
		{ "<C-g>r", mode = { "n", "v" }, desc = "git: [R]evert to the specific commit" },
		{ "<C-g>R", mode = { "n", "v" }, desc = "git: [R]evert the current file to the specific commit" },
	},
	config = config,
}
