local config = {}

---Set normal mode keymap
---@param key string Left-hand side {lhs} of the mapping.
---@param func string|function Right-hand side {rhs} of the mapping.
---@param desc string Keymap description.
local function nmap(bufnr, key, func, desc)
	vim.keymap.set("n", key, func, { buffer = bufnr, desc = "LSP: " .. desc })
end

---Config on attach lsp server
---@param _ unknown Attached LSP client
---@param bufnr number Number of a buffer
local function on_attach(_, bufnr)
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	-- NOTE: To use fuzzy finder instead of quickfix list
	-- other keymaps like GoToImplementation, GoToReferences are set in telescope.nvim config
	nmap(bufnr, "gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
	nmap(bufnr, "gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
end

---Return default lsp configs table
local default_config = {
	on_attach = on_attach,
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
	handlers = {
		["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
			underline = true,
			float = { source = "if_many" },
			severity_sort = true,
			signs = true,
			virtual_text = false,
			update_in_insert = true,
		}),
	},
}

config["tsserver"] = vim.tbl_deep_extend("force", default_config, {
	handlers = {
		---filter `index.d.ts` out from `textDocument/definition` result
		---@see https://github.com/typescript-language-server/typescript-language-server/issues/216#issuecomment-1005272952
		["textDocument/definition"] = function(err, result, method, ...)
			if vim.islist(result) and #result > 1 then
				local filtered_results = {}
				for _, v in ipairs(result) do
					if not string.match(v.targetUri, "react/.*/index%.d%.ts") then
						table.insert(filtered_results, v)
					end
				end

				return vim.lsp.handlers["textDocument/definition"](err, filtered_results, method, ...)
			end
			vim.lsp.handlers["textDocument/definition"](err, result, method, ...)
		end,
	},
})

config["pyright"] = vim.tbl_deep_extend("force", default_config, {
	settings = {
		pyright = {
			disableOrganizeImports = true,
		},
		python = {
			analysis = {
				-- Using ruff
				ignore = { "*" },
				typeCheckingMode = "off",
			},
		},
	},
})

config["ruff_lsp"] = vim.tbl_deep_extend("force", default_config, {
	init_options = {
		settings = {
			ruff = {
				args = {
					"--no-color",
					"--no-interactive",
					"--no-progress",
					"--no-emoji",
				},
			},
		},
	},
})

config["gopls"] = vim.tbl_deep_extend("force", default_config, {
	hints = {
		assignVariableTypes = true,
		compositeLiteralFields = true,
		constantValues = true,
		functionTypeParameters = true,
		parameterNames = true,
		rangeVariableTypes = true,
	},
})

config["lua_ls"] = vim.tbl_deep_extend("force", default_config, {
	settings = {
		Lua = {
			diagnostics = { globals = { "vim" } },
			telemetry = { enable = false },
			runtime = {
				version = "LuaJIT",
				pathStrict = true,
				path = { "?.lua", "?/init.lua" },
			},
			workspace = {
				library = vim.list_extend(vim.api.nvim_get_runtime_file("lua", true), {
					vim.fn.stdpath("config") .. "/lua",
					-- vim.fn.*, vim.api.*
					vim.env.VIMRUNTIME .. "/lua",
					-- vim.uv.*, (vim.loop.*)
					"${3rd}/luv/library",
					"${3rd}/busted/library",
					"${3rd}/luaassert/library",
				}),
				checkThirdParty = false,
			},
		},
	},
})

config["jsonls"] = vim.tbl_deep_extend("force", default_config, {
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
})

---@see https://github.com/golang/tools/blob/master/gopls/doc/inlayHints.md
config["stylelint_lsp"] = vim.tbl_deep_extend("force", default_config, {
	filetypes = { "css", "less", "scss", "sugarss", "vue", "wxss" },
})

return setmetatable(config, {
	__index = function()
		return default_config
	end,
})
