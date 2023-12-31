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
		{ "<C-g>b", mode = { "n", "v" } },
		{ "<C-g>v", mode = { "n", "v" } },
		{ "<C-g>P", mode = { "n", "v" } },
		{ "<C-g>p", mode = { "n", "v" } },
		{ "<C-g>d", mode = { "n", "v" } },
		{ "<C-g>r", mode = { "n", "v" } },
		{ "<C-g>R", mode = { "n", "v" } },
	},
	config = config,
}
