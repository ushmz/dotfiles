---Mark current files you want to revisit later
local function add_file()
	require("harpoon.mark").add_file()
end

---View all project marks
local function toggle_quick_menu()
	require("harpoon.ui").toggle_quick_menu()
end

-- ---Switch to the desired mark
-- ---@param index integer
-- local function nav_file(index)
-- 	require("harpoon.ui").nav_file(index)
-- end

---Switch to the next mark index
local function nav_next()
	require("harpoon.ui").nav_next()
end

---Switch to the prev mark index
local function nav_prev()
	require("harpoon.ui").nav_prev()
end

return {
	"ThePrimeagen/harpoon",
	cmd = { "Harpoon" },
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
	},
	keys = {
		{ "<leader><C-a>", add_file, mode = "n", desc = "Harpoon: [A]dd File to Harpoon Marks" },
		{ "<leader><C-q>", toggle_quick_menu, mode = "n", desc = "Harpoon: Toggle Harpoon [Q]uick Menu" },
		{ "<leader><C-n>", nav_next, mode = "n", desc = "Harpoon: Switch to the [N]ext Harpoon Mark Index" },
		{ "<leader><C-p>", nav_prev, mode = "n", desc = "Harpoon: Switch to the [P]revious Harpoon Mark Index" },
	},
	config = function()
		require("harpoon").setup({
			-- sets the marks upon calling `toggle` on the ui, instead of require `:w`.
			save_on_toggle = false,

			-- saves the harpoon file upon every change. disabling is unrecommended.
			save_on_change = true,

			-- sets harpoon to run the command immediately as it's passed to the terminal when calling `sendCommand`.
			enter_on_sendcmd = false,

			-- closes any tmux windows harpoon that harpoon creates when you close Neovim.
			tmux_autoclose_windows = false,

			-- filetypes that you want to prevent from adding to the harpoon list menu.
			excluded_filetypes = { "harpoon" },

			-- set marks specific to each git branch inside git repository
			mark_branch = false,
		})
	end,
}
