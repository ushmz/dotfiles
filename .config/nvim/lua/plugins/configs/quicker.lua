local function expand()
	require("quicker").expand({ before = 1, after = 1, add_to_existing = true })
end

local function collapse()
	require("quicker").collapse()
end

local function toggle_quickfix()
	require("quicker").toggle()
end

local function toggle_loclist()
	require("quicker").toggle({ loclist = true })
end

return {
	"stevearc/quicker.nvim",
	event = { "FileType qf" },
	opts = {
		opts = {
			buflisted = false,
			number = true,
			signcolumn = "auto",
			winfixheight = true,
			wrap = false,
		},
		keys = {
			{ "q", toggle_quickfix, desc = "Toggle quickfix" },
			{ "<leader>l", toggle_loclist, desc = "Toggle loclist" },
			{ ">", expand, desc = "Expand quickfix content" },
			{ "<", collapse, desc = "Collapse quickfix content" },
		},
		edit = {
			enable = true,
			autosave = "unmodified",
		},
		-- Keep the cursor to the right of the filename and lnum columns
		constrain_cursor = true,
		type_icons = {
			E = "",
			W = " ",
			I = "",
			-- N = "",
			H = "",
		},
	},
}
