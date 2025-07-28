---@type vim.lsp.Config
return {
	-- NOTE: It seems that cspell-lsp set the default global config path to "~/Library/Preferences/cspell/".
	cmd = { "cspell-lsp", "--stdio", "--config", "~/.config/cspell/cspell.json" },
	root_markers = {
		".git",
		"cspell.json",
		".cspell.json",
		"cspell.json",
		".cSpell.json",
		"cSpell.json",
		"cspell.config.js",
		"cspell.config.cjs",
		"cspell.config.json",
		"cspell.config.yaml",
		"cspell.config.yml",
		"cspell.yaml",
		"cspell.yml",
	},
}
