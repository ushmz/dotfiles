local M = {}

---Strip the leading and trailing whitespace from a string.
---@param str string
---@return string # The stripped string.
local strip = function(str)
	return string.match(str, "^%s*(.-)%s*$")
end

---Get the path and position from a string.
---@param str string # The string to parse.
---@param sep string # The separator to use.
---@return string filepath # The file path.
---@return string row # Line(row) number.
---@return string col # Column number.
---@return string text # The text.
local get_path_and_pos = function(str, sep)
	local result = {}
	local regex = ("([^%s]+)"):format(sep)
	for token in str:gmatch(regex) do
		table.insert(result, token)
	end
	local filepath, row, col = unpack(result, 1, 3)
	local text = table.concat(result, ":", 4, #result)
	return filepath, row, col, strip(text)
end

---Get the tail of the path and the path to display.
---e.g. .config/nvim/init.lua -> init.lua, .config/nvim
---@param file_path string
---@return string tail # The tail of the path (file name in most case).
---@return string directory_path # Directory path to display
local get_path_and_tail = function(file_path)
	local utils = require("telescope.utils")
	local tail = utils.path_tail(file_path)
	local path_without_tail = require("plenary.strings").truncate(file_path, #file_path - #tail, "")
	local directory_path = utils.transform_path({ path_display = { "truncate" } }, path_without_tail)

	return tail, directory_path
end

---Generate a new entry maker for the result has the tail of the path.
---Show the tail of the path in the first, and the (dimmed) parent directory in the second.
---@param base_entry_maker any
---@param splitter function
---@return function
local function entry_maker_stand_out_tail(base_entry_maker, splitter)
	local strings = require("plenary.strings")
	local entry_display = require("telescope.pickers.entry_display")
	local devicons = require("nvim-web-devicons")
	local default_icon = devicons.get_icon("fname", { default = true })

	return function(line)
		local entry = base_entry_maker(line)
		local displayer = entry_display.create({
			separator = " ",
			items = {
				{ width = strings.strdisplaywidth(default_icon) },
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
---@param base_entry_maker any
---@param splitter any
---@return function
local function entry_maker_highlight_parent_dir(base_entry_maker, splitter)
	local strings = require("plenary.strings")
	local entry_display = require("telescope.pickers.entry_display")
	local devicons = require("nvim-web-devicons")
	local default_icon = devicons.get_icon("fname", { default = true })

	return function(line)
		local entry = base_entry_maker(line)
		local displayer = entry_display.create({
			separator = "",
			items = {
				{ width = strings.strdisplaywidth(default_icon) }, -- Icon
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

---Create a new entry maker for the file picker.
---@see https://github.com/nvim-telescope/telescope.nvim/issues/2014#issuecomment-1541063264
---@param opts? any
---@return function
M.create_for_find_files = function(opts)
	local base_entry_maker = require("telescope.make_entry").gen_from_file(opts or {})
	local splitter = function(et)
		local tail, parent_dir = get_path_and_tail(et.value)
		local icon, iconhl = require("telescope.utils").get_devicons(tail)
		return icon, iconhl, parent_dir, tail
	end
	return entry_maker_stand_out_tail(base_entry_maker, splitter)
end

---Create a new entry maker for the old file picker.
---@param opts? any
---@return function
M.create_for_old_files = function(opts)
	local base_entry_maker = require("telescope.make_entry").gen_from_file(opts or {})
	local splitter = function(et)
		local tail, parent_dir = get_path_and_tail(et.value)
		local icon, iconhl = require("telescope.utils").get_devicons(tail)
		return icon, iconhl, parent_dir, tail
	end
	return entry_maker_stand_out_tail(base_entry_maker, splitter)
end

---Create a new entry maker for the grep picker.
---@param opts? table
---@return function
M.create_for_live_grep = function(opts)
	local base_entry_maker = require("telescope.make_entry").gen_from_vimgrep(opts or {})
	local splitter = function(et)
		local filepath, row, col, text = get_path_and_pos(et.value, ":")
		local filename, parent_dir = get_path_and_tail(filepath)
		local icon, iconhl = require("telescope.utils").get_devicons(filename)
		return icon, iconhl, parent_dir, filename, row, col, text
	end
	return entry_maker_highlight_parent_dir(base_entry_maker, splitter)
end

---Create a new entry maker for the lsp_references picker.
---@param opts? table
---@return function
M.create_for_lsp_references = function(opts)
	local base_entry_maker = require("telescope.make_entry").gen_from_quickfix(opts or {})
	local splitter = function(et)
		local filepath = vim.F.if_nil(et.filename, et.bufname)
		local filename, parent_dir = get_path_and_tail(filepath)
		local icon, iconhl = require("telescope.utils").get_devicons(filename)
		return icon, iconhl, parent_dir, filename, tostring(et.lnum), tostring(et.col), et.text
	end
	return entry_maker_highlight_parent_dir(base_entry_maker, splitter)
end

---Create a new entry maker for the lsp_implementations picker.
---@param opts? table
---@return function
M.create_for_lsp_implementations = function(opts)
	local base_entry_maker = require("telescope.make_entry").gen_from_quickfix(opts or {})
	local splitter = function(et)
		local filepath = vim.F.if_nil(et.filename, et.bufname)
		local filename, parent_dir = get_path_and_tail(filepath)
		local icon, iconhl = require("telescope.utils").get_devicons(filename)
		return icon, iconhl, parent_dir, filename, tostring(et.lnum), tostring(et.col), et.text
	end
	return entry_maker_highlight_parent_dir(base_entry_maker, splitter)
end

return M
