local pnpm = vim.fs.root(0, { "pnpm-lock.yml", "yaml-lock.yaml" })

---@param client vim.lsp.Client
---@param bufnr number
---@param cmd string
local function exec_code_action_sync(client, bufnr, cmd)
	local range_params = vim.lsp.util.make_range_params(0, "utf-8")
	local params = {
		textDocument = range_params.textDocument,
		range = range_params.range,
		context = { only = { cmd }, diagnostics = {} },
	}

	-- NOTE: Use `request_sync` of `vim.lsp.Client` instead of `vim.lsp.buf_request_sync` to filter target language server
	local res = client:request_sync("textDocument/codeAction", params, 3000, bufnr)
	if res and res.result then
		for _, r in ipairs(res.result) do
			if r.edit then
				local encoding = vim.lsp.get_client_by_id(client.id).offset_encoding or "utf-8"
				vim.lsp.util.apply_workspace_edit(r.edit, encoding)
			end
		end
	end
end

---@type vim.lsp.Config
return {
	cmd = pnpm and { "pnpm", "biome", "lsp-proxy" } or { "npx", "biome", "lsp-proxy" },
	root_dir = function(bufnr, cb)
		-- NOTE: To avoid being used `package.json` as root directory marker (default behavior of `lspconfig`),
		-- we use only `biome.json` or `biome.jsonc` as root directory marker.
		local root_dir = vim.fs.root(bufnr, { "biome.json", "biome.jsonc" })
		if root_dir then
			cb(root_dir)
		else
			cb(nil)
		end
	end,
	on_attach = function(client, bufnr)
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = bufnr,
			---@param args { buf: integer }
			callback = function(args)
				if client:supports_method("textDocument/codeAction") then
					exec_code_action_sync(client, bufnr, "source.fixAll")
					exec_code_action_sync(client, bufnr, "source.organizeImports")
				end

				if client:supports_method("textDocument/formatting") then
					vim.lsp.buf.format({
						bufnr = bufnr,
						async = false,
						timeout_ms = 5000,
					})
				end
			end,
		})
	end,
}
