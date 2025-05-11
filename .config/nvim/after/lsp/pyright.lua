---@type vim.lsp.Config
return {
	settings = {
		pyright = {
			disableOrganizeImports = true,
		},
		python = {
			analysis = {
				-- Using ruff
				ignore = { "*" },
				typeCheckingMode = "off",
			},
		},
	},
}
