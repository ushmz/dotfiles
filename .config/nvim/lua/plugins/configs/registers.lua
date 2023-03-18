local function config()
	local registers = require("registers")
	registers.setup({
		show = '*+"-/_=#%.0123456789abcdefghijklmnopqrstuvwxyz:',
		show_empty = true,
		register_user_command = true,
		system_clipboard = false,
		trim_whitespace = true,
		hide_only_whitespace = true,
		show_register_types = true,

		bind_keys = {
			-- Show the window when pressing " in normal mode, applying the selected register as part of a motion, which is the default behavior of Neovim
			normal = registers.show_window({ mode = "motion" }),
			-- Show the window when pressing " in visual mode, applying the selected register as part of a motion, which is the default behavior of Neovim
			visual = registers.show_window({ mode = "motion" }),
			-- Show the window when pressing <C-R> in insert mode, inserting the selected register, which is the default behavior of Neovim
			insert = registers.show_window({ mode = "insert" }),

			-- When pressing the key of a register, apply it with a very small delay, which will also highlight the selected register
			registers = registers.apply_register({ delay = 0.1 }),
			-- Immediately apply the selected register line when pressing the return key
			return_key = registers.apply_register(),
			-- Close the registers window when pressing the Esc key
			escape = registers.close_window(),

			-- Move the cursor in the registers window down when pressing <C-N>
			ctrl_n = registers.move_cursor_down(),
			-- Move the cursor in the registers window up when pressing <C-P>
			ctrl_p = registers.move_cursor_up(),
			-- Move the cursor in the registers window down when pressing <C-J>
			ctrl_j = registers.move_cursor_down(),
			-- Move the cursor in the registers window up when pressing <C-K>
			ctrl_k = registers.move_cursor_up(),
			-- Clear the register of the highlighted line when pressing <DEL>
			delete = registers.clear_highlighted_register(),
			-- Clear the register of the highlighted line when pressing <BS>
			backspace = registers.clear_highlighted_register(),
		},

		events = {
			-- When a register line is highlighted,
      -- show a preview in the main buffer with how the register will be applied,
      -- but only if the register will be inserted or pasted
			on_register_highlighted = registers.preview_highlighted_register({ if_mode = { "insert", "paste" } }),
		},

		symbols = {
			newline = "⏎",
			space = " ",
			tab = "·",
			register_type_charwise = "ᶜ",
			register_type_linewise = "ˡ",
			register_type_blockwise = "ᵇ",
		},

		window = {
			max_width = 100,
			highlight_cursorline = true,
			border = "rounded",
			transparency = 0,
		},

		sign_highlights = {
			cursorline = "Visual",
			selection = "Constant",
			default = "Function",
			unnamed = "Statement",
			read_only = "Type",
			expression = "Exception",
			black_hole = "Error",
			alternate_buffer = "Operator",
			last_search = "Tag",
			delete = "Special",
			yank = "Delimiter",
			history = "Number",
			named = "Todo",
		},
	})
end

return {
	"tversteeg/registers.nvim",
	name = "registers",
	cmd = "Registers",
	keys = {
		{ '"', mode = { "n", "v" } },
		{ "<C-R>", mode = "i" },
	},
	config = config,
}
