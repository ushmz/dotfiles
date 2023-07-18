local M = {}

---Get the tail of the path and the path to display.
---@param filename string
---@return string
---@return string
M.get_path_and_tail = function(filename)
	local utils = require("telescope.utils")
	local bufname_tail = utils.path_tail(filename)
	local path_without_tail = require("plenary.strings").truncate(filename, #filename - #bufname_tail, "")
	local path_to_display = utils.transform_path({
		path_display = { "truncate" },
	}, path_without_tail)

	return bufname_tail, path_to_display
end

---Create a new entry maker for the file picker.
---@see https://github.com/nvim-telescope/telescope.nvim/issues/2014#issuecomment-1541063264
---@param opts any
---@return function
M.create = function(opts)
	return function(line)
		local make_entry = require("telescope.make_entry")
		local strings = require("plenary.strings")
		local utils = require("telescope.utils")
		local entry_display = require("telescope.pickers.entry_display")
		local devicons = require("nvim-web-devicons")
		local def_icon = devicons.get_icon("fname", { default = true })
		-- local level_up = vim.v.count

		local entry_make = make_entry.gen_from_file(opts or {})
		local entry = entry_make(line)
		local displayer = entry_display.create({
			separator = " ",
			items = {
				{ width = strings.strdisplaywidth(def_icon) },
				{ width = nil },
				{ remaining = true },
			},
		})

		entry.display = function(et)
			local tail_raw, path_to_display = M.get_path_and_tail(et.value)
			local tail = tail_raw .. " "
			local icon, iconhl = utils.get_devicons(tail_raw)

			return displayer({
				{ icon, iconhl },
				tail,
				{ path_to_display, "TelescopeResultsComment" },
			})
		end
		return entry
	end
end

return M
