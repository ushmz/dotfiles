local status1, lsp = pcall(require, "lspconfig")
if not status1 then
	return
end

local status2, cmp_lsp = pcall(require, "cmp_nvim_lsp")
if not status2 then
	return
end

local status3, ml = pcall(require, "mason-lspconfig")
if not status3 then
	return
end

--- Plugin configs.
---@type { config: function, setup: function}
local M = {}

local on_attach = function(client, bufnr)
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	local keymap = vim.api.nvim_buf_set_keymap
	local opts = { noremap = true, silent = true }
	keymap(bufnr, "n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
	keymap(bufnr, "n", "gr", "<Cmd>lua vim.lsp.buf.references()<CR>", opts)
	keymap(bufnr, "n", "gt", "<Cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	keymap(bufnr, "n", "gi", "<Cmd>lua vim.lsp.buf.implementation()<CR>", opts)
end

local custom_servers = {
	["lua_ls"] = {
		prefer_null_ls = true,
		settings = {
			Lua = {
				diagnostics = { globals = { "vim" } },
				workspace = { library = vim.api.nvim_get_runtime_file("", true), checkThirdParty = true },
			},
		},
	},
	["jsonls"] = {
		prefer_null_ls = true,
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
	},
	["stylelint_lsp"] = {
		prefer_null_ls = true,
		filetypes = { "css", "less", "scss", "sugarss", "vue", "wxss" },
	},
}

M.config = function()
	local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
	for type, icon in pairs(signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
	end

	vim.diagnostic.config({
		virtual_text = false,
		signs = true,
		underline = true,
		update_in_insert = true,
		float = { source = "if_many" },
	})

	vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
		vim.lsp.diagnostic.on_publish_diagnostics,
		{ underline = true, update_in_insert = false, virtual_text = false, severity_sort = true }
	)

	local on_attach_with_null_ls = function(client, bufnr)
		client.server_capabilities.documentHighlightProvider = false
		client.server_capabilities.documentFormattingProvider = false
		on_attach(client, bufnr)
	end

	local capabilities = cmp_lsp.default_capabilities()
	capabilities.textDocument.completion.completionItem.snippetSupport = true

	ml.setup_handlers({
		function(server_name)
			local config = {
				on_attach = on_attach,
				capabilities = capabilities or {},
			}
			if custom_servers[server_name] then
				config = custom_servers[server_name]
				if custom_servers[server_name]["prefer_null_ls"] then
					config.on_attach = on_attach_with_null_ls
				else
					config.on_attach = on_attach
				end
			end
			lsp[server_name].setup(config)
		end,
	})

	-- mason doesn't have `dartls` install option
	lsp.dartls.setup({
		on_attach = on_attach,
		capabilities = capabilities,
		cmd = { "dart", "language-server", "--protocol=lsp" },
		filetypes = { "dart" },
		root_pattern = { "pubspec.yaml" },
		init_options = {
			closingLabels = true,
			flutterOutline = true,
			onlyAnalyzeProjectsWithOpenFiles = true,
			outline = true,
			suggestFromUnimportedLibraries = true,
		},
		settings = {
			dart = {
				completeFunctionCalls = true,
				showTodos = true,
			},
		},
	})
end

return M
