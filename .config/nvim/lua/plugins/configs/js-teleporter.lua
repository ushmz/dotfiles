local function config()
	require("js-teleporter").setup({})
end

return {
	"ushmz/js-teleporter.nvim",
	ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
	},
	config = config,
}
