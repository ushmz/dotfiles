local config = function()
	require("incline").setup({
		window = {
			padding = 0,
			margin = { horizontal = 0, vertical = 0 },
			overlap = {
				borders = true,
				statusline = false,
				tabline = false,
				winbar = false,
			},
			placement = {
				horizontal = "right",
				vertical = "bottom",
			},
		},
		render = function(props)
			local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
			if filename == "" then
				filename = "[No Name]"
			end
			local ft_icon, ft_color = require("nvim-web-devicons").get_icon_color(filename)
			local modified = vim.bo[props.buf].modified
			local res = {
				ft_icon
						and { " ", ft_icon, " ", guibg = ft_color, guifg = require("incline.helpers").contrast_color(ft_color) }
					or "",
				" ",
				{ filename, gui = modified and "bold,italic" or "bold" },
				guibg = "#44406e",
			}
			if props.focused then
				local code_context = require("nvim-navic").get_data(props.buf) or {}
				for _, item in ipairs(code_context) do
					table.insert(res, {
						{ " > ", group = "NavicSeparator" },
						{ item.icon, group = "NavicIcons" .. item.type },
						{ item.name, group = "NavicText" },
					})
				end
			end
			table.insert(res, " ")
			return res
		end,
	})
end

return {
	"b0o/incline.nvim",
  cond = false,
	event = { "BufRead", "BufNewFile" },
	dependencies = {
		"SmiteshP/nvim-navic",
		"nvim-tree/nvim-web-devicons",
	},
	config = config,
}
