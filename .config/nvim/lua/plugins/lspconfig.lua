local status1, lsp = pcall(require, "lspconfig")
if not status1 then
	return
end

local status2, ml = pcall(require, "mason-lspconfig")
if not status2 then
	return
end

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
	float = {
		source = "if_many",
	},
})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	underline = true,
	update_in_insert = false,
	virtual_text = false,
	severity_sort = true,
})

local on_attach = function(client, bufnr)
	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end

	local opts = { noremap = true, silent = true }
	buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
	buf_set_keymap("n", "gr", "<Cmd>lua vim.lsp.buf.references()<CR>", opts)
	buf_set_keymap("n", "gt", "<Cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	buf_set_keymap("n", "gi", "<Cmd>lua vim.lsp.buf.implementation()<CR>", opts)

	if client.server_capabilities.documentFormattingProvider then
		buf_set_keymap("n", "<leader>f", "<Cmd>lua vim.lsp.buf.format({timeout_ms = 5000})<CR>", opts)
	end

	if client.server_capabilities.documentHighlightProvider then
		vim.api.nvim_create_augroup("LspDocumentHighlight", { clear = true })
		vim.api.nvim_clear_autocmds({ group = "LspDocumentHighlight" })
		vim.api.nvim_create_autocmd({ "CursorHold" }, {
			callback = vim.lsp.buf.document_highlight,
			group = "LspDocumentHighlight",
		})
		vim.api.nvim_create_autocmd({ "Cursormoved" }, {
			callback = vim.lsp.buf.clear_references,
			group = "LspDocumentHighlight",
		})
		vim.api.nvim_set_hl(0, "LspReferenceText", { ctermbg = 240, bg = "#515761" })
		vim.api.nvim_set_hl(0, "LspReferenceRead", { ctermbg = 240, bg = "#515761" })
		vim.api.nvim_set_hl(0, "LspReferenceWrite", { ctermbg = 240, bg = "#515761" })
	end
end

local on_attach_with_null_ls = function(client, bufnr)
	client.server_capabilities.documentHighlightProvider = false
	client.server_capabilities.documentFormattingProvider = false
	on_attach(client, bufnr)
end

local custom_servers = {
	["sumneko_lua"] = {
		prefer_null_ls = true,
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},

				workspace = {
					library = vim.api.nvim_get_runtime_file("", true),
					checkThirdParty = false,
				},
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

local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

ml.setup_handlers({
	function(server_name)
		local config = {
			on_attach = on_attach,
			capabilities = capabilities,
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
