---@type vim.lsp.Config
return {
	root_dir = function(bufnr, cb)
		local tailwind_root = vim.fs.root(bufnr, { "tailwind.config.js", "tailwind.config.ts", "tailwind.config.mjs" })
		if tailwind_root then
			cb(nil)
			return
		end

		local root_dir = vim.fs.root(bufnr, { "package.json", ".git" })
		cb(root_dir)
	end,
}
