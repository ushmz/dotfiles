local status1, mason = pcall(require, "mason")
if not status1 then
	return
end

local status2, lspconfig = pcall(require, "mason-lspconfig")
if not status2 then
	return
end

mason.setup({
	ui = {
		border = "rounded",
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

lspconfig.setup({
	automatic_installation = true,
	ensure_installed = {
		-- LSP
		"bashls",
		"cssls",
		"dockerls",
		"eslint",
		"gopls",
		"html",
		"jsonls",
		"kotlin_language_server",
		"lua_ls",
		"prismals",
		"pyright",
		"rust_analyzer",
		"solargraph",
		"sqlls",
		"stylelint_lsp",
		"tailwindcss",
		"tsserver",
		"yamlls",
	},
})

-- Following tools cannot install via `ensure_installed` option,
-- make sure to install them manually ;)
-- FYI: 'WhoIsSethDaniel/mason-tool-installer.nvim'
-- 'flake8',
-- 'ktlint',
-- 'markdownlint',
-- 'rubocop',
-- 'black',
-- 'goimports',
-- 'prettier',
-- 'shfmt',
-- 'yamlfmt',
--
-- Install like this.
-- vim.cmd[[
--   MasonInstall flake8 ktlint markdownlint rubocop black goimports prettier shfmt yamlfmt
-- ]]
