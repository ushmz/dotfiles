local ok, formatting = pcall(require, "null-ls.builtins.formatting.gofmt")
if not ok then
	return
end

return {
	formatting,
}
