---@type vim.lsp.Config
return {
	root_dir = function(bufnr, cb)
		local exclud_dir = vim.fs.root(bufnr, { "biome.json", "biome.jsonc" })
		if exclud_dir then
			cb(nil)
			return
		end

		local root_dir = vim.fs.root(bufnr, {
			".eslintrc",
			".eslintrc.js",
			".eslintrc.cjs",
			".eslintrc.yaml",
			".eslintrc.yml",
			".eslintrc.json",
			"eslint.config.js",
			"eslint.config.mjs",
			"eslint.config.cjs",
			"eslint.config.ts",
			"eslint.config.mts",
			"eslint.config.cts",
		})

		if root_dir then
			cb(root_dir)
		else
			cb(nil)
		end
	end,
}
