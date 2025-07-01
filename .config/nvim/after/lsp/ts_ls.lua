---@type vim.lsp.Config
return {
	root_markers = { "turbo.json" },
	on_attach = function(client, bufnr)
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false

		vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
		-- NOTE: To use fuzzy finder instead of quickfix list
		-- other keymaps like GoToImplementation, GoToReferences are set in telescope.nvim config
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "LSP: [G]oto [D]efinition" })
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "LSP: [G]oto [D]eclaration" })
	end,
	handlers = {
		---filter `index.d.ts` out from `textDocument/definition` result
		---@see https://github.com/typescript-language-server/typescript-language-server/issues/216#issuecomment-1005272952
		["textDocument/definition"] = function(err, result, method, ...)
			if vim.islist(result) and #result > 1 then
				local filtered_results = {}
				for _, v in ipairs(result) do
					if not string.match(v.targetUri, "react/.*/index%.d%.ts") then
						table.insert(filtered_results, v)
					end
				end

				return vim.lsp.handlers["textDocument/definition"](err, filtered_results, method, ...)
			end
			vim.lsp.handlers["textDocument/definition"](err, result, method, ...)
		end,
	},
}
