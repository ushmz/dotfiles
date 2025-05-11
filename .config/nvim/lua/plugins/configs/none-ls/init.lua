---Format documents with only clients by null-ls
---@param bufnr number|nil Format with the clients attached to the given buffer, (defaults: current buffer (0))
---@param timeout_ms number|nil Request timeout (defaults: 5000)
local function format_with_none_ls(bufnr, timeout_ms)
	vim.lsp.buf.format({
		bufnr = bufnr or 0,
		timeout_ms = timeout_ms or 5000,
		filter = function(clt)
			return clt.name == "null-ls"
		end,
	})
end

local function toggle_source(source)
	require("null-ls").toggle({ name = source })
end

local function config()
	local nls_sources = {}
	for _, package in ipairs(require("mason-registry").get_installed_packages()) do
		local categories = package.spec.categories

		for _, cat in ipairs(categories) do
			if cat == require("mason-core.package").Cat.Formatter then
				local ok, formatter = pcall(require, "null-ls.builtins.formatting." .. package.name)
				if ok then
					table.insert(nls_sources, formatter)
				end

				local ok, code_action = pcall(require, "null-ls.code_actions." .. package.name)
				if ok then
					table.insert(nls_sources, code_action)
				end
			end
			if cat == require("mason-core.package").Cat.Linter then
				local ok, linter = pcall(require, "null-ls.builtins.diagnostics." .. package.name)
				if ok then
					table.insert(nls_sources, linter)
				end

				local ok, code_action = pcall(require, "null-ls.code_actions." .. package.name)
				if ok then
					table.insert(nls_sources, code_action)
				end
			end
		end
	end

	local extras = require("plugins.configs.none-ls.extra")
	for _, source in ipairs(extras) do
		table.insert(nls_sources, source)
	end

	local cspell = require("plugins.configs.none-ls.cspell")
	for _, source in ipairs(cspell) do
		table.insert(nls_sources, source)
	end

	require("null-ls").setup({
		sources = nls_sources,
		on_attach = function(client, bufnr)
			local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
			if ft == "json" or ft == "yaml" or ft == "toml" then
				require("null-ls").disable({ "prettier" })
			end
			if client.server_capabilities.documentFormattingProvider then
				vim.keymap.set("n", "==", function()
					format_with_none_ls(bufnr)
				end, { buffer = true, desc = "LSP: format with none_ls" })

				local fmtag = vim.api.nvim_create_augroup("LspDocumentFormatting", {})
				vim.api.nvim_create_autocmd("BufWritePre", {
					buffer = bufnr,
					group = fmtag,
					callback = function()
						format_with_none_ls(bufnr)
					end,
				})
			end
		end,
	})

	vim.api.nvim_create_user_command("NullLsToggle", function(args)
		local fargs = args.fargs
		if #fargs ~= 1 then
			vim.api.nvim_err_writeln("Invalid number of arguments: " .. #fargs .. ", expected 1")
			return
		end
		toggle_source(fargs[1])
	end, { nargs = "*", desc = "Toggle null-ls" })
end

return {
	"nvimtools/none-ls.nvim",
  ft = {"*"},
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
		"davidmh/cspell.nvim",
	},
	config = config,
}
