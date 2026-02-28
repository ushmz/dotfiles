local ok, formatting = pcall(require, "null-ls.builtins.formatting.stylua")
if not ok then
	return
end

return {
	formatting.with({
		condition = function(utils)
			return not utils.root_has_file({ "stylua.toml", "stylua.json" })
		end,
	}),
}
