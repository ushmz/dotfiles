---@type vim.lsp.Config
return {
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
