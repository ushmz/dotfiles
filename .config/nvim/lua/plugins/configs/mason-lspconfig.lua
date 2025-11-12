return {
	"mason-org/mason-lspconfig.nvim",
	lazy = true,
	dependencies = {
		{ "mason-org/mason.nvim" },
	},
	config = function()
		local servers = {
			-- cSpell:disable
			"bashls",
			"dockerls",
			"eslint",
			"gopls",
			"html",
			"jsonls",
			"kotlin_language_server",
			"lua_ls",
			"pyright",
			"ruff",
			"rubocop",
			"rust_analyzer",
			"ruby_lsp",
			"sqlls",
			"tailwindcss",
			"vtsls",
			-- cSpell:enable
		}

		require("mason-lspconfig").setup({
			automatic_enable = true,
			ensure_installed = jit.os == "OSX" and servers or {},
		})
		-- Manually install like this
		-- FYI: 'WhoIsSethDaniel/mason-tool-installer.nvim'
		-- vim.cmd([[
		--   MasonInstall cspell dockerfile-language-server goimports html-lsp markdownlint
		--    \ prettier rustfmt shfmt
		--    \ yaml-language-server yamlfmt yamllint
		--   ]])
		--
		-- You should also install the dictionaries for cspell
		-- vim.cmd([[
		--  !npm install -g ...
		-- ]])
	end,
}
