local function config()
	require("nvim-ts-autotag").setup({})
end

return {
	"windwp/nvim-ts-autotag",
	event = { "InsertEnter" },
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	config = config,
}
