local function config()
	require("conform").setup({
		formatters_by_ft = {
			css = { "stylefmt" },
			dart = { "dart_format" },
			go = { "gofmt", "goimports" },
			html = { "eslint", "prettierd" },
			javascript = { "eslint", "prettierd" },
			javascriptreact = { "eslint", "prettierd" },
			json = { "eslint", "prettierd" },
			lua = { "stylua" },
			markdown = { "eslint", "prettierd" },
			python = { "black", "isort" },
			rust = { "rustfmt" },
			sh = { "shfmt" },
			sql = { "sqlfluff" },
			toml = { "taplo" },
			typescript = { "eslint", "prettierd" },
			typescriptreact = { "eslint", "prettierd" },
			yaml = { "yamlfmt" },
			["*"] = { "trim_newlines", "trim_whitespace" },
		},
		format_on_save = function(bufnr)
			if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
				return
			end
			local bufname = vim.api.nvim_buf_get_name(bufnr)
			if bufname:match("/node_modules/") then
				return
			end
			return { async = true, lsp_fallback = true, timeout_ms = 1000 }
		end,
	})

	vim.api.nvim_create_user_command("Format", function()
		require("conform").format({ async = true, lsp_fallback = true })
	end, { desc = "Format the current buffer" })

	vim.api.nvim_create_user_command("FormatDisable", function()
		vim.g.disable_autoformat = true
	end, { desc = "Diable autoformatting on save for this buffer" })

	vim.api.nvim_create_user_command("FormatEnable", function()
		vim.g.disable_autoformat = true
	end, { desc = "Enable autoformatting on save for this buffer" })
end

return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"==",
			function()
				require("conform").format({ async = true, lsp_fallback = true, timeout_ms = 1000 })
			end,
			mode = "n",
			desc = "Format the current buffer",
		},
	},
	config = config,
	init = function()
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
}
