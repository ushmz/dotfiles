local function config()
	require("nvim-autopairs").setup({
		disable_filetype = { "TelescopePrompt", "vim" },
	})
end

return {
	"windwp/nvim-autopairs",
	event = { "InsertEnter" },
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	config = config,
}
