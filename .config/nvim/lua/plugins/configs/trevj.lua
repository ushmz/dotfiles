return {
	"AckslD/nvim-trevJ.lua",
	module = "trevj",
	keys = {
		{
			",j",
			function()
				require("trevj").format_at_cursor()
			end,
			mode = "n",
			desc = "rev[J] Format at cursor",
		},
	},
	config = function()
		require("trevj").setup({
			containers = {
				lua = {
          table_constructor = { final_separator = ",", final_end_line = true },
          arguments = { final_separator = false, final_end_line = true },
          parameters = { final_separator = false, final_end_line = true },
        },
				html = {
					start_tag = {
						final_separator = false,
						final_end_line = true,
						skip = { tag_name = true },
					},
				},
			},
		})
	end,
}
