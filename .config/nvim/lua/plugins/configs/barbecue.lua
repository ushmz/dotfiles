local function config()
	require("barbecue").setup({
		attach_navic = false,
		create_autocmd = false,
		show_modified = true,
	})
	vim.api.nvim_create_autocmd({
		"WinScrolled",
		"WinResized",
		"BufWinEnter",
		"CursorHold",
		"InsertLeave",
		-- include this if you have set `show_modified` to `true`
		"BufModifiedSet",
	}, {
		group = vim.api.nvim_create_augroup("barbecue.updater", {}),
		callback = function()
			require("barbecue.ui").update()
		end,
	})

	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
			local buf = args.buf
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			if client.server_capabilities.documentSymbolProvider then
				require("nvim-navic").attach(client, buf)
			end
		end,
	})
end

return {
	"utilyre/barbecue.nvim",
	name = "barbecue",
	event = { "BufRead", "BufNewFile" },
	dependencies = {
		"SmiteshP/nvim-navic",
		"nvim-tree/nvim-web-devicons",
	},
	config = config,
}
