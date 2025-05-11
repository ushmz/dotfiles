---@type vim.lsp.Config
return {
	init_options = {
		settings = {
			ruff = {
				args = {
					"--no-color",
					"--no-interactive",
					"--no-progress",
					"--no-emoji",
				},
			},
		},
	},
}
