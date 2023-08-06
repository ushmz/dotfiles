local M = {}

---Get the path and position from a string.
---@param str string The string to parse.
---@param sep string The separator to use.
---@return string, string, string, string
local get_path_and_pos = function(str, sep)
	local result = {}
	local regex = ("([^%s]+)"):format(sep)
	for token in str:gmatch(regex) do
		table.insert(result, token)
	end
	local filepath, row, col = unpack(result, 1, 3)
	local text = table.concat(result, ":", 4, #result)
	return filepath, row, col, text
end

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
M.create_for_find_files = function(opts)
	local make_entry = require("telescope.make_entry")
	local strings = require("plenary.strings")
	local utils = require("telescope.utils")
	local entry_display = require("telescope.pickers.entry_display")
	local devicons = require("nvim-web-devicons")
	local def_icon = devicons.get_icon("fname", { default = true })
	-- local level_up = vim.v.count

	return function(line)
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

M.create_for_live_grep = function(opts)
	local make_entry = require("telescope.make_entry")
	local strings = require("plenary.strings")
	local utils = require("telescope.utils")
	local entry_display = require("telescope.pickers.entry_display")
	local devicons = require("nvim-web-devicons")
	local def_icon = devicons.get_icon("fname", { default = true })

	return function(line)
		local entry_make = make_entry.gen_from_vimgrep(opts or {})
		local entry = entry_make(line)
		local displayer = entry_display.create({
			separator = "",
			items = {
				{ width = strings.strdisplaywidth(def_icon) }, -- Icon
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
			local filepath, row, col, text = get_path_and_pos(et.value, ":")
			local filename, directory_path = M.get_path_and_tail(filepath)
			local icon, iconhl = utils.get_devicons(filename)

			return displayer({
				{ icon, iconhl },
				{ " ", nil },
				{ directory_path .. "/", "TelescopeResultsIdentifier" },
				{ filename, nil },
        { ":", "TelescopeResultsComment" },
				{ row, "TelescopeResultsNumber" },
				{ ":", "TelescopeResultsComment" },
				{ col, "TelescopeResultsNumber" },
				{ "\t", nil },
				{ text, "TelescopeResultsComment" },
			})
		end
		return entry
	end
end

return M
