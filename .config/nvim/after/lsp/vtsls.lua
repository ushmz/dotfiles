---@type vim.lsp.Config
return {
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false

    -- NOTE: To use fuzzy finder instead of quickfix list
    -- other keymaps like GoToImplementation, GoToReferences are set in telescope.nvim config
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "LSP: [G]oto [D]efinition" })
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "LSP: [G]oto [D]eclaration" })
  end,
	root_dir = function(bufnr, cb)
		local turbo_root = vim.fs.root(bufnr, { "turbo.json", "turbo.jsonc" })
		if turbo_root then
			cb(turbo_root)
			return
		end

		local root_dir = vim.fs.root(bufnr, { "package.json", "tsconfig.json", "jsconfig.json" })
		if root_dir then
			cb(root_dir)
			return
		end

		cb(nil)
	end,
	settings = {
		vtsls = {
			autoUseWorkspaceTsdk = true,
		},
		typescript = {
			preferences = {
				preferGoToSourceDefinition = true,
			},
			tsserver = {
				maxTsServerMemory = 8 * 1024,
			},
		},
		javascript = {
			preferences = {
				preferGoToSourceDefinition = true,
			},
		},
	},
}
