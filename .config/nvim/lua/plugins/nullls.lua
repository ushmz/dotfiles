-- Following tools cannot install via `ensure_installed` option of mason,
local ext_fmt = {
	"dart_format",
	"ktlint",
	"markdownlint",
	"rubocop",
	"black",
	"goimports",
	"prettier",
	"shfmt",
	"yamlfmt",
}

local ext_diag = {
	"flake8",
	"rubocop",
}

local function config()
	local nls_sources = {}
	for _, package in ipairs(require("mason-registry").get_installed_packages()) do
		local categories = package.spec.categories[1]
		if categories == require("mason-core.package").Cat.Formatter then
			table.insert(nls_sources, require("null-ls").builtins.formatting[package.name])
		end
		if categories == require("mason-core.package").Cat.Linter then
			table.insert(nls_sources, require("null-ls").builtins.diagnostics[package.name])
		end
	end

	for _, fmt in ipairs(ext_fmt) do
		table.insert(nls_sources, require("null-ls").builtins.formatting[fmt])
	end

	for _, diag in ipairs(ext_diag) do
		table.insert(nls_sources, require("null-ls").builtins.diagnostics[diag])
	end

	require("null-ls").setup({
		sources = nls_sources,
		on_attach = function(client, bufnr)
			if client.server_capabilities.documentFormattingProvider then
				vim.api.nvim_buf_set_keymap(
					bufnr,
					"n",
					"<leader>f",
					[[<Cmd>lua vim.lsp.buf.format({ timeout_ms = 5000, bufnr = bufnr, filter = function(clt) return clt.name == 'null-ls' end })<CR>]],
					{ noremap = true, silent = true }
				)

				local fmtag = vim.api.nvim_create_augroup("LspDocumentFormatting", {})
				vim.api.nvim_create_autocmd("BufWritePre", {
					buffer = bufnr,
					group = fmtag,
					callback = function()
						vim.lsp.buf.format({
							bufnr = bufnr,
							filter = function(clt)
								return clt.name == "null-ls"
							end,
						})
					end,
				})
			end
		end,
	})
end

return {
	"jose-elias-alvarez/null-ls.nvim",
	event = { "BufNewFile", "BufReadPre", "FileReadPre" },
	dependencies = { "williamboman/mason.nvim" },
	config = config,
}
