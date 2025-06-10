---@param client vim.lsp.Client
---@param bufnr number
---@param cmd string
local function exec_code_action_sync(client, bufnr, cmd)
	local params = vim.lsp.util.make_range_params()
	params.context = { only = { cmd }, diagnostics = {} }
	params.range = cmd.range

	-- NOTE: Use `request_sync` of `vim.lsp.Client` instead of `vim.lsp.buf_request_sync` to filter target language server
	local res = client.request_sync("textDocument/codeAction", params, 5000, bufnr)
	if res and res.result then
		for _, r in ipairs(res.result) do
			if r.edit then
				local encoding = vim.lsp.get_client_by_id(r.edit.client_id).offset_encoding or "utf-8"
				vim.lsp.util.apply_workspace_edit(r.edit, encoding)
			end
		end
	end
end

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
	on_attach = function(client, bufnr)
		local fmtag = vim.api.nvim_create_augroup("LspDocumentFormatting", {})
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = bufnr,
			group = fmtag,
			callback = function(args)
				vim.lsp.buf.format({ bufnr = bufnr, timeout_ms = 5000 })
				-- TODO : execute "textDocument/codeAction" to apply the fix
				exec_code_action_sync(client, bufnr, "source.fixAll")
			end,
		})
	end,
}
