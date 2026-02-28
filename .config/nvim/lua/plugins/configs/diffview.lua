return {
	"sindrets/diffview.nvim",
	cmd = { "DiffviewOpen" },
	config = function()
		local actions = require("diffview.actions")
		require("diffview").setup({
			keymaps = {
				view = {
					{ "n", "gf", false },
					{ "n", "<C-w>gf", false },
					{ "n", "<C-w><CR>", actions.goto_file_tab, { desc = "Open the file in a new tabpage" } },
					{
						"n",
						"<C-w>f",
						function()
							actions.goto_file_split()
							vim.cmd("wincmd L")
						end,
						{ desc = "Open the file in a new split" },
					},
					{
						"n",
						"ZZ",
						function()
							vim.cmd("DiffviewClose")
						end,
						{ desc = "Close diffview" },
					},
				},
				file_panel = {
					{ "n", "gf", false },
					{ "n", "<C-w>gf", false },
					{ "n", "<C-w><CR>", actions.goto_file_tab, { desc = "Open the file in a new tabpage" } },
					{
						"n",
						"<C-w><C-f>",
						function()
							actions.goto_file_split()
							vim.cmd("wincmd L")
						end,
						{ desc = "Open the file in a new split" },
					},
					{
						"n",
						"ZZ",
						function()
							vim.cmd("DiffviewClose")
						end,
						{ desc = "Close diffview" },
					},
				},
			},
		})
	end,
}
