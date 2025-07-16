---@type vim.lsp.Config
return {
	settings = {
		gopls = {
			gofumpt = true, -- Use gofumpt for formatting
		},
	},
	hints = {
		assignVariableTypes = true,
		compositeLiteralFields = true,
		constantValues = true,
		functionTypeParameters = true,
		parameterNames = true,
		rangeVariableTypes = true,
	},
}
