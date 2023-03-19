local function mason()
	require("mason").setup({
		ui = {
			border = "rounded",
			icons = {
				package_installed = "✓",
				package_pending = "➜",
				package_uninstalled = "✗",
			},
		},
	})
end

local function mason_lspconfig()
	require("mason-lspconfig").setup({
		ensure_installed = {
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
	-- 'stylua',
	-- 'yamlfmt',
	--
	-- Install like this.
	-- vim.cmd[[
	--   MasonInstall flake8 ktlint markdownlint rubocop black goimports prettier shfmt stylua yamlfmt
	--   MasonInstall bashls cssls dockerls eslint gopls html jsonls kotlin_language_server lua_ls
	--   MasonInstall prismals pyright rust_analyzer solargraph sqlls stylelint_lsp tailwindcss tsserver yamlls
	-- ]]
end

return {
	{
		"williamboman/mason-lspconfig.nvim",
		cmd = "Mason",
		dependencies = {
			{
				"williamboman/mason.nvim",
				config = mason,
			},
		},
		config = mason_lspconfig,
	},
}
