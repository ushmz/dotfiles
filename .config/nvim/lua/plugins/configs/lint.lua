local function config()
	require("lint").linters_by_ft = {
		css = { "stylelint" },
		go = { "golangcilint" },
		javascript = { "eslint" },
		javascriptreact = { "eslint" },
		json = { "jsonlint" },
		lua = { "luacheck" },
		markdown = { "markdownlint" }, -- "vale"
		python = { "flake8" },
		rust = { "cargo" },
		sh = { "shellcheck" },
		typescript = { "eslint" },
		typescriptreact = { "eslint" },
		vue = { "eslint" },
		yaml = { "yamllint" },
	}
end

return {
	"mfussenegger/nvim-lint",
	event = { "BufNewFile", "BufReadPre", "FileReadPre" },
	config = config,
}
