-- Following tools cannot install via `ensure_installed` option of mason,
local formatters = {
	"eslint_d",
	"dart_format",
	"ktlint",
	"markdownlint",
	"rubocop",
	"black",
	"gofmt",
	"goimports",
	"shfmt",
	"yamlfmt",
}

local diagnostics = {
	"rubocop",
	"ruff-lsp",
}

local code_actions = {
	"eslint_d",
}

---@type table
local sources = {}

for _, fmt in ipairs(formatters) do
	local ok, source = pcall(require, "none-ls.formatting." .. fmt)
	if ok then
		table.insert(sources, source)
	end
end

for _, diag in ipairs(diagnostics) do
	local ok, source = pcall(require, "none-ls.diagnostics." .. diag)
	if ok then
		table.insert(sources, source)
	end
end

for _, action in ipairs(code_actions) do
	local ok, source = pcall(require, "none-ls.code_actions." .. action)
	if ok then
		table.insert(sources, source)
	end
end

return sources
