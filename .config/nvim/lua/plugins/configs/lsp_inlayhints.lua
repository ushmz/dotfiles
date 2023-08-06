return {
	"lvimuser/lsp-inlayhints.nvim",
	config = function()
		require("lsp-inlayhints").setup({
			inlay_hints = {
				parameter_hints = {
					show = true,
					prefix = "<- ",
					separator = ", ",
					remove_colon_start = false,
					remove_colon_end = true,
				},
				type_hints = {
					show = true,
					prefix = "",
					separator = ", ",
					remove_colon_start = false,
					remove_colon_end = false,
				},
				only_current_line = false,
				-- separator between types and parameter hints. Note that type hints are
				-- shown before parameter
				labels_separator = "  ",
				-- highlight group
				highlight = "LspInlayHint",
				-- virt_text priority
				priority = 0,
			},
		})
		vim.api.nvim_set_hl(0, "LspInlayHint", { fg = "#d8d8d8", bg = "#3a3a3a" })

		vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
		vim.api.nvim_create_autocmd("LspAttach", {
			group = "LspAttach_inlayhints",
			callback = function(args)
				if not (args.data and args.data.client_id) then
					return
				end

				local bufnr = args.buf
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				require("lsp-inlayhints").on_attach(client, bufnr)
			end,
		})
	end,
}
