local function config()
	require("lualine").setup({
		options = {
			icons_enabled = true,
			theme = "jellybeans",
			section_separators = { left = "", right = "" },
			component_separators = { left = "", right = "" },
			disabled_filetypes = { "TelescopePrompt" },
			always_divide_middle = true,
			globalstatus = true,
		},
		sections = {
			lualine_a = {},
			lualine_b = { "branch", "diff" },
			lualine_c = {
				{
					"filename",
					file_status = true,
					path = 1,
				},
			},
			lualine_x = {
				{
					"diagnostics",
					source = { "nvim-lsp", "null-ls" },
					symbols = { error = " ", warn = " ", info = " ", hint = " " },
				},
				"filetype",
        "encoding",
				"location",
			},
			lualine_y = {},
			lualine_z = {},
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = {
				{
					"filename",
					file_status = true,
					path = 1,
				},
			},
			lualine_x = { "location" },
			lualine_y = {},
			lualine_z = {},
		},
		tabline = {},
	})
end

return {
	"nvim-lualine/lualine.nvim",
	event = { "VeryLazy" },
	config = config,
}
