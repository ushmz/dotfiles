-- Following tools cannot install via `ensure_installed` option of mason,
local formatters = {
	"ktlint",
	"markdownlint",
	"gofmt",
	"goimports",
	"shfmt",
}

---@type table
local sources = {}

for _, fmt in ipairs(formatters) do
	local ok, source = pcall(require, "none-ls.formatting." .. fmt)
	if ok then
		table.insert(sources, source)
	end
end

return sources
