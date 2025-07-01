local function config()
	require("js-teleporter").setup({
		test_roots = { "__test__", "__tests__", "test", "tests" },
	})
end

return {
	"ushmz/js-teleporter.nvim",
	ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
	},
	config = config,
}
