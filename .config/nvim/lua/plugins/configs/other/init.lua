local function config()
	require("other-nvim").setup({
		mappings = {
			"golang",
			{
				pattern = "(.*).ts",
				target = "%1",
				transformer = "jest",
				context = "jest",
			},
			{
				pattern = "(.*).test.ts",
				target = "%1",
				transformer = "jest",
				context = "jest",
			},
		},
		transformers = {
			jest = require("plugins.configs.other.transformer").jest,
		},
		style = {
			border = "rounded",
			seperator = "|",
			width = 0.7,
			minHeight = 5,
		},
	})
end

return {
	"rgroli/other.nvim",
	cond = false,
	cmd = { "Other", "OtherTabNew", "OtherSplit", "OtherVSplit", "OtherClear" },
	config = config,
}
