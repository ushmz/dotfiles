---@type vim.lsp.Config
return {
	init_options = {
		userLanguages = {
			postcss = "css",
		},
	},
	settings = {
		tailwindcss = {
			validate = true,
			includeLanguages = {
				eelixir = "html-eex",
				elixir = "phoenix-heex",
				eruby = "erb",
				heex = "phoenix-heex",
				htmlangular = "html",
				templ = "html",
			},
			lint = {
				cssConflict = "warning",
				recommendedVariantOrder = "warning",
				invalidApply = "error",
				invalidConfigPath = "error",
				invalidScreen = "error",
				invalidTailwindDirective = "error",
				invalidVariant = "error",
			},
		},
		workspace_required = true,
	},
}
