local function config()
	require("nvim-ts-autotag").setup({
		opts = {
			enable_close_on_slash = true,
		},
	})
end

return {
	"windwp/nvim-ts-autotag",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	config = config,
}
