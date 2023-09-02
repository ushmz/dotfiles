-- These two local variables `capabilities` and `on_attach`
-- are completely same as one in lsp configuration file (`lspconfig.lua`).
-- We have to specify some lsp options (i.e. `on_attach` and `capabilities`) on configuring `flutter-tools`.
local capabilities = require("cmp_nvim_lsp").default_capabilities()

---Config on attach lsp server
---@param client unknown
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

local function config()
	require("flutter-tools").setup({
		ui = {
			border = "rounded",
			notification_style = "native",
		},
		decorations = {
			statusline = {
				app_version = false,
				device = false,
			},
		},
		debugger = { -- integrate with nvim dap + install dart code debugger
			enabled = false,
			run_via_dap = false, -- use dap instead of a plenary job to run flutter apps
			-- if empty dap will not stop on any exceptions, otherwise it will stop on those specified
			-- see |:help dap.set_exception_breakpoints()| for more info
			exception_breakpoints = {},
			-- register_configurations = function(paths)
			-- 	require("dap").configurations.dart = {
			-- 	  <put here config that you would find in .vscode/launch.json>
			-- 	}
			-- end,
		},
		flutter_path = "/usr/local/bin/flutter",
		-- flutter_lookup_cmd = "dirname $(which flutter)",
		fvm = false,
		widget_guides = {
			enabled = true,
		},
		closing_tags = {
			highlight = "Comment", -- highlight group name for the closing tag
			prefix = "// ",
			enabled = true,
		},
		dev_log = {
			enabled = true,
			open_cmd = "tabedit",
		},
		dev_tools = {
			autostart = false,
			auto_open_browser = false,
		},
		outline = {
			open_cmd = "30vnew",
			auto_open = false,
		},
		lsp = {
			color = {
				enabled = true,
				background = true,
				background_color = nil,
				foreground = false,
				virtual_text = false,
				virtual_text_str = "■",
			},
			on_attach = on_attach,
			capabilities = capabilities,
			settings = {
				showTodos = true,
				completeFunctionCalls = true,
				renameFilesWithClasses = "prompt",
				enableSnippets = true,
				dart = {
					completeFunctionCalls = true,
					showTodos = true,
				},
			},
		},
	})
end

return {
	"akinsho/flutter-tools.nvim",
	ft = { "dart" },
	dependencies = {
		"nvim-lua/plenary.nvim",
		-- "stevearc/dressing.nvim",
	},
	config = config,
}
