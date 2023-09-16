local M = {}

---Generate a new entry maker for the result has the tail of the path.
---Show the tail of the path in the first, and the (dimmed) parent directory in the second.
---@param base_entry_maker function
---@param splitter function
---@return function
M.entry_maker_stand_out_tail = function(base_entry_maker, splitter)
	local default_icon = require("nvim-web-devicons").get_icon("fname", { default = true })

	return function(line)
		local entry = base_entry_maker(line)
		local displayer = require("telescope.pickers.entry_display").create({
			separator = " ",
			items = {
				{ width = require("plenary.strings").strdisplaywidth(default_icon) },
				{ width = nil },
				{ remaining = true },
			},
		})

		entry.display = function(et)
			local icon, iconhl, parent_dir, tail = splitter(et)
			return displayer({
				{ icon, iconhl },
				tail,
				{ parent_dir, "TelescopeResultsComment" },
			})
		end
		return entry
	end
end

---Generate a new entry maker for the result has the row and column position.
---Highlight the parent directory, and dimmed matched text.
---@param base_entry_maker function
---@param splitter function
---@return function
M.entry_maker_highlight_parent_dir = function(base_entry_maker, splitter)
	local default_icon = require("nvim-web-devicons").get_icon("fname", { default = true })

	return function(line)
		local entry = base_entry_maker(line)
		local displayer = require("telescope.pickers.entry_display").create({
			separator = "",
			items = {
				{ width = require("plenary.strings").strdisplaywidth(default_icon) }, -- Icon
				{ width = nil }, -- Space
				{ width = nil }, -- Parent directory path
				{ width = nil }, -- File name
				{ width = nil }, -- Separator (Colon)
				{ width = nil }, -- Matched char position (line number)
				{ width = nil }, -- Separator (Colon)
				{ width = nil }, -- Matched char position (column)
				{ width = nil }, -- Space
				{ remaining = true }, -- Matched line text
			},
		})

		entry.display = function(et)
			local icon, iconhl, parent_dir, filename, row, col, text = splitter(et)

			return displayer({
				{ icon, iconhl },
				{ " ", nil },
				{ parent_dir .. "/", "TelescopeResultsIdentifier" },
				{ filename, nil },
				{ ":", "TelescopeResultsComment" },
				{ row, "TelescopeResultsNumber" },
				{ ":", "TelescopeResultsComment" },
				{ col, "TelescopeResultsNumber" },
				{ " ", nil },
				{ text, "TelescopeResultsComment" },
			})
		end
		return entry
	end
end

M.set = function()
	vim.api.nvim_set_hl(0, "TelescopeNormal", { link = "NormalNC" })
	vim.api.nvim_set_hl(0, "TelescopeMatching", { fg = "#B5BD68", bold = true })
end

return M
