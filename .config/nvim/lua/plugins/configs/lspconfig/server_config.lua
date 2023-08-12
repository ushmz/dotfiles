---Set normal mode keymap
---@param key string Left-hand side {lhs} of the mapping.
---@param func string|function Right-hand side {rhs} of the mapping.
---@param desc string Keymap description.
local function nmap(bufnr, key, func, desc)
	vim.keymap.set("n", key, func, { buffer = bufnr, desc = "LSP: " .. desc })
end

---Config on attach lsp server
---@param client unknown Attached LSP client
---@param bufnr number Number of a buffer
local function on_attach(client, bufnr)
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	nmap(bufnr, "gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
	nmap(bufnr, "gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
	nmap(bufnr, "<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
	nmap(bufnr, "<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
	nmap(bufnr, "<leader>wl", function()
		vim.notify(vim.inspect(vim.lsp.buf.list_workspace_folders()), vim.log.levels.INFO)
	end, "[W]orkspace [L]ist Folders")
end

---Return default lsp configs table
local function default_server_config()
	return {
		on_attach = on_attach,
		capabilities = require("cmp_nvim_lsp").default_capabilities(),
	}
end

local config = {
	---@see https://github.com/golang/tools/blob/master/gopls/doc/inlayHints.md
	["gopls"] = vim.tbl_deep_extend("force", default_server_config(), {
		hints = {
			assignVariableTypes = true,
			compositeLiteralFields = true,
			constantValues = true,
			functionTypeParameters = true,
			parameterNames = true,
			rangeVariableTypes = true,
		},
	}),
	["lua_ls"] = vim.tbl_deep_extend("force", default_server_config(), {
		settings = {
			Lua = {
				diagnostics = { globals = { "vim" } },
				telemetry = { enable = false },
				workspace = {
					library = vim.api.nvim_get_runtime_file("", true),
					checkThirdParty = false,
				},
			},
		},
	}),
	["jsonls"] = vim.tbl_deep_extend("force", default_server_config(), {
		settings = {
			json = {
				schemas = {
					{
						fileMatch = { "package.json" },
						url = "https://json.schemastore.org/package.json",
					},
					{
						fileMatch = { "tsconfig*.json" },
						url = "https://json.schemastore.org/tsconfig.json",
					},
					{
						fileMatch = { ".prettierrc", ".prettierrc.json", "prettier.config.json" },
						url = "https://json.schemastore.org/prettierrc.json",
					},
					{
						fileMatch = { ".eslintrc", ".eslintrc.json" },
						url = "https://json.schemastore.org/eslintrc.json",
					},
					{
						fileMatch = { ".stylelintrc", ".stylelintrc.json", "stylelint.config.json" },
						url = "http://json.schemastore.org/stylelintrc.json",
					},
					{
						fileMatch = { "/.github/workflows/*" },
						url = "https://json.schemastore.org/github-workflow.json",
					},
				},
			},
		},
	}),
	["stylelint_lsp"] = vim.tbl_deep_extend("force", default_server_config(), {
		filetypes = { "css", "less", "scss", "sugarss", "vue", "wxss" },
	}),
}

return setmetatable(config, {
	__index = function()
		return {
			on_attach = on_attach,
			capabilities = require("cmp_nvim_lsp").default_capabilities(),
		}
	end,
})
