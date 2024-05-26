local function config()
	local colors = require("theme").colors
	require("hawtkeys").setup({
		homerow = 2,
		-- the fingers you want to use as the powerfingers, default is {2,3,6,7}
		powerFingers = { 2, 3, 6, 7 },
		customMaps = {
			--- EG local map = vim.api
			--- map.nvim_set_keymap('n', '<leader>1', '<cmd>echo 1')
			{
				["map.nvim_set_keymap"] = { --name of the expression
					modeIndex = "1", -- the position of the mode setting
					lhsIndex = "2", -- the position of the lhs setting
					rhsIndex = "3", -- the position of the rhs setting
					optsIndex = "4", -- the position of the index table
					method = "dot_index_expression", -- if the function name contains a dot
				},
			},
			--- EG local map2 = vim.api.nvim_set_keymap
			["map2"] = { --name of the function
				modeIndex = 1, --if you use a custom function with a fixed value, eg normRemap, then this can be a fixed mode eg 'n'
				lhsIndex = 2,
				rhsIndex = 3,
				optsIndex = 4,
				method = "function_call",
			},
			-- If you use whichkey.register with an alias eg wk.register
			["wk.register"] = {
				method = "which_key",
			},
			-- If you use lazy.nvim's keys property to configure keymaps in your plugins
			["lazy"] = {
				method = "lazy",
			},
		},
		highlights = {
			HawtkeysMatchGreat = { fg = colors.green, bold = true },
			HawtkeysMatchGood = { fg = colors.green },
			HawtkeysMatchOk = { fg = colors.yellow },
			HawtkeysMatchBad = { fg = colors.red },
		},
	})
end

return {
	"tris203/hawtkeys.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	cmd = { "Hawtkeys", "HawtkeysAll", "HawtkeysDupes" },
	config = config,
}
