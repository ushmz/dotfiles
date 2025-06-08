---@type vim.lsp.Config
return {
	root_markers = { "biome.json", "biome.jsonc" },
	root_dir = function(bufnr, cb)
		local root_dir = vim.fs.root(bufnr, { "biome.json", "biome.jsonc" })
		if root_dir then
			vim.print("biome config exist: " .. root_dir)
			cb(vim.fn.fnamemodify(root_dir, ":h"))
		else
			cb(nil)
		end
	end,
	single_file_support = true,
}
