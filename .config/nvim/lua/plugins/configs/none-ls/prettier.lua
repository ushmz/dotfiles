local ok, formatting = pcall(require, "null-ls.builtins.formatting.prettier")
if not ok then
	return
end

return {
	formatting.with({
		condition = function(utils)
			return not utils.root_has_file({ "biome.json", "biome.jsonc" })
		end,
		filetypes = vim.tbl_filter(function(ft)
			return ft ~= "json" or ft ~= "jsonc" or ft ~= "yaml"
		end, formatting.filetypes),
	}),
}
