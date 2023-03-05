---Config on attach lsp server
---@param client any
---@param bufnr number Number of a buffer
local function on_attach(client, bufnr)
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	---Set normal mode keymap
	---@param key string Left-hand side {lhs} of the mapping.
	---@param func string|function Right-hand side {rhs} of the mapping.
	---@param desc string Keymap description.
	local function nmap(key, func, desc)
		vim.keymap.set("n", key, func, { buffer = bufnr, desc = "LSP: " .. desc })
	end
	nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
	nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
	nmap("gt", vim.lsp.buf.type_definition, "[G]oto [T]ype definition")
	nmap("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")

	nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
	nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
	nmap("<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, "[W]orkspace [L]ist Folders")
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
