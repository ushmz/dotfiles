---Config on attach lsp server
---@param client any
---@param bufnr number Number of a buffer
local function on_attach(client, bufnr)
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	local keymap = vim.api.nvim_buf_set_keymap
	local opts = { noremap = true, silent = true }
	keymap(bufnr, "n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
	keymap(bufnr, "n", "gr", "<Cmd>lua vim.lsp.buf.references()<CR>", opts)
	keymap(bufnr, "n", "gt", "<Cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	keymap(bufnr, "n", "gi", "<Cmd>lua vim.lsp.buf.implementation()<CR>", opts)
end

---Return capabilities config table
---@return table
local function capabilities()
	local cap = require("cmp_nvim_lsp").default_capabilities()
	cap.textDocument.completion.completionItem.snippetSupport = true
	return cap
end

---Return custom lsp configs table
---@return table
local function custom_server_configs()
	local custom_servers = {
		["lua_ls"] = {
			on_attach = on_attach,
			capabilities = capabilities(),
			settings = {
				Lua = {
					diagnostics = { globals = { "vim" } },
					workspace = { library = vim.api.nvim_get_runtime_file("", true), checkThirdParty = true },
				},
			},
		},
		["jsonls"] = {
			on_attach = on_attach,
			capabilities = capabilities(),
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
			on_attach = on_attach,
			capabilities = capabilities(),
			filetypes = { "css", "less", "scss", "sugarss", "vue", "wxss" },
		},
	}

	return setmetatable(custom_servers, {
		__index = function()
			return {
				on_attach = on_attach,
				capabilities = capabilities(),
			}
		end,
	})
end

local function config()
	local colors = { Error = "#CC6666", Warn = "#F0C674", Hint = "#81A2BE", Info = "#B5BD68" }
	for type, color in pairs(colors) do
		vim.api.nvim_set_hl(0, "Diagnostic" .. type, { fg = color })
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
		float = { source = "if_many" },
	})

	vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
		vim.lsp.diagnostic.on_publish_diagnostics,
		{ underline = true, update_in_insert = false, virtual_text = false, severity_sort = true }
	)

	require("mason-lspconfig").setup_handlers({
		function(server_name)
			if server_name == "dartls" then
				-- mason doesn't have `dartls` install option
				require("lspconfig").dartls.setup({
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
			local conf = custom_server_configs()[server_name]
			require("lspconfig")[server_name].setup(conf)
		end,
	})
end

return {
	{
		"neovim/nvim-lspconfig",
		event = { "InsertEnter" },
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp", event = { "InsertEnter" } },
		},
		config = config,
	},
}
