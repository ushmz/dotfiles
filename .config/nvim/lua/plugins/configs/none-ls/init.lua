local function config()
	local extras = require("plugins.configs.none-ls.extra")
	local prettier = require("plugins.configs.none-ls.prettier")
	local gofmt = require("plugins.configs.none-ls.gofmt")
	local cspell = require("plugins.configs.none-ls.cspell")
	local stylua = require("plugins.configs.none-ls.stylua")

	require("null-ls").setup({
		sources = {
			unpack(prettier),
			unpack(gofmt),
			unpack(stylua),
			unpack(cspell),
			unpack(extras),
		},
	})

	vim.api.nvim_create_user_command("NullLsToggle", function(args)
		local fargs = args.fargs
		if #fargs ~= 1 then
			vim.api.nvim_err_writeln("Invalid number of arguments: " .. #fargs .. ", expected 1")
			return
		end

		require("null-ls").toggle({ name = fargs[1] })
	end, { nargs = "*", desc = "Toggle null-ls" })
end

return {
	"nvimtools/none-ls.nvim",
	ft = { "*" },
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
		"davidmh/cspell.nvim",
	},
	config = config,
}
