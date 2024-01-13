local function config()
	local cspell = require("plugins.configs.lint.cspell")
	require("lint").linters.cspell.args = cspell.args

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
		vue = { "eslint_d" },
		yaml = { "yamllint" },
	}

	vim.api.nvim_create_autocmd({ "BufRead", "BufWritePost" }, {
		callback = function()
			if vim.bo.filetype then
				require("lint").try_lint("cspell")
			end
		end,
	})

	vim.api.nvim_create_user_command("CSpellAppend", cspell.append_to_dictionary, {
		nargs = "?",
		bang = true,
	})
end

return {
	"mfussenegger/nvim-lint",
	event = { "BufNewFile", "BufRead" },
	config = config,
}
