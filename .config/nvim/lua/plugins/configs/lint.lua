local function config()
	local cspell = require("lint").linters.cspell
	cspell.args = {
		"lint",
		"--no-color",
		"--no-progress",
		"--no-summary",
		"--show-suggestions",
	}

	require("lint").linters_by_ft = {
		css = { "stylelint" },
		go = { "golangcilint" },
		javascript = { "eslint_d" },
		javascriptreact = { "eslint_d" },
		json = { "jsonlint" },
		lua = { "luacheck" },
		markdown = { "markdownlint" }, -- "vale"
		python = { "flake8" },
		rust = { "cargo" },
		sh = { "shellcheck" },
		typescript = { "eslint_d" },
		typescriptreact = { "eslint_d" },
		vue = { "eslint" },
		yaml = { "yamllint" },
	}

	vim.api.nvim_create_autocmd({ "InsertLeave", "BufReadPost", "TextChanged", "BufWritePost" }, {
		callback = function()
			local linters = require("lint").linters_by_ft[vim.bo.filetype]
			if linters then
				require("lint").try_lint("cspell")
			end
		end,
	})
end

return {
	"mfussenegger/nvim-lint",
	event = { "BufNewFile", "BufReadPre", "FileReadPre" },
	config = config,
}
