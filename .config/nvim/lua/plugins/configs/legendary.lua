return {
	"mrjones2014/legendary.nvim",
	cmd = "Legendary",
	config = function()
		require("legendary").setup({
			include_buildtin = true,
			include_legendary_cmds = false,
			extensions = {
				lazy_nvim = true,
				smart_splits = true,
				diffview = true,
			},
		})
	end,
	keys = {
		{
			"<C-g>l",
			mode = { "n", "v", "x" },
			function()
				require("legendary").find({ filters = { require("legendary.filters").current_mode() } })
			end,
			desc = "Open legendary",
		},
	},
	dependencies = {
		-- "kkharji/sqlite.lua",
		"stevearc/dressing.nvim",
		-- "nvim-telescope/telescope.nvim",
	},
}
