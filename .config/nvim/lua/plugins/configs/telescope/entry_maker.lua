local default_icon = require("nvim-web-devicons").get_icon("fname", { default = true })
local entry_display = require("telescope.pickers.entry_display")
local icon_width = require("plenary.strings").strdisplaywidth(default_icon)
local make_entry = require("telescope.make_entry")
local utils = require("telescope.utils")

local M = {}

---Strip the leading and trailing whitespace from a string.
---@param str string
---@return string # The stripped string.
local function strip(str)
	return string.match(str, "^%s*(.-)%s*$")
end

---Get the path and position from a string.
---@param str string # The string to parse.
---@param sep string # The separator to use.
---@return string filepath # The file path.
---@return string row # Line(row) number.
---@return string col # Column number.
---@return string text # The text.
local function get_path_and_pos(str, sep)
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
local function get_path_and_tail(file_path)
	local tail = utils.path_tail(file_path)
	local path_without_tail = require("plenary.strings").truncate(file_path, #file_path - #tail, "")
	local directory_path = utils.transform_path({ path_display = { "truncate" } }, path_without_tail)

	return tail, directory_path
end

---Get the highlighted entry maker for the file picker.
---Put the file name first and the dimmed parent directory path in the second.
---@param opts? table
---@return function
local function get_highlighted_entry_maker_from_file(opts)
	local displayer = entry_display.create({
		separator = " ",
		items = {
			{ width = icon_width },
			{ width = nil },
			{ remaining = true },
		},
	})

	return function(line)
		local entry_make = make_entry.gen_from_file(opts or {})
		local entry = entry_make(line)

		entry.display = function(et)
			local tail, directory_path = get_path_and_tail(et.value)
			local icon, iconhl = utils.get_devicons(tail)

			return displayer({
				{ icon, iconhl },
				tail,
				{ directory_path, "Comment" },
			})
		end
		return entry
	end
end

---Get the highlighted entry maker for the grep picker.
---Applied a different highlight to the parent directory path,
---added row(line) and column number, and dimmed the matched line text.
---@param opts? table
---@return function
local function get_highlighted_entry_maker_from_vimgrep(opts)
	local displayer = entry_display.create({
		separator = "",
		items = {
			{ width = icon_width },
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

	return function(line)
		local entry_maker = make_entry.gen_from_vimgrep(opts or {})
		local entry = entry_maker(line)

		entry.display = function(et)
			local filepath, row, col, text = get_path_and_pos(et.value, ":")
			local filename, directory_path = get_path_and_tail(filepath)
			local icon, iconhl = utils.get_devicons(filename)

			return displayer({
				{ icon, iconhl },
				{ " ", nil },
				{ directory_path .. "/", "Directory" },
				{ filename, nil },
				{ ":", "Comment" },
				{ row, "Number" },
				{ ":", "Comment" },
				{ col, "Number" },
				{ " ", nil },
				{ text, "Comment" },
			})
		end
		return entry
	end
end

---Get the highlighted entry maker for the quickfix.
---Applied a different highlight to the parent directory path,
---added row(line) and column number, and dimmed the matched line text.
---@param opts? table
---@return function
local function get_highlighted_entry_maker_from_quickfix(opts)
	local displayer = entry_display.create({
		separator = "",
		items = {
			{ width = icon_width },
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

	return function(input)
		local entry_maker = make_entry.gen_from_quickfix(opts or {})
		local entry = entry_maker(input)

		entry.display = function(et)
			local filepath = vim.F.if_nil(et.filename, et.bufname)
			local filename, directory_path = get_path_and_tail(filepath)
			local icon, iconhl = utils.get_devicons(filename)

			return displayer({
				{ icon, iconhl },
				{ " ", nil },
				{ directory_path .. "/", "Directory" },
				{ filename, nil },
				{ ":", "Comment" },
				{ tostring(et.lnum), "Number" },
				{ ":", "Comment" },
				{ tostring(et.col), "Number" },
				{ " ", nil },
				{ strip(et.text), "Comment" },
			})
		end
		return entry
	end
end

---Create a new entry maker for the file picker.
---@see https://github.com/nvim-telescope/telescope.nvim/issues/2014#issuecomment-1541063264
---@param opts? any
---@return function
function M.create_for_find_files(opts)
	return get_highlighted_entry_maker_from_file(opts)
end

---Create a new entry maker for the old file picker.
---@param opts? any
---@return function
function M.create_for_old_files(opts)
	return get_highlighted_entry_maker_from_file(opts)
end

---Create a new entry maker for the grep picker.
---@param opts? table
---@return function
function M.create_for_live_grep(opts)
	return get_highlighted_entry_maker_from_vimgrep(opts)
end

---Create a new entry maker for the lsp_references picker.
---@param opts? table
---@return function
function M.create_for_lsp_references(opts)
	return get_highlighted_entry_maker_from_quickfix(opts)
end

---Create a new entry maker for the lsp_implementations picker.
---@param opts? table
---@return function
function M.create_for_lsp_implementations(opts)
	return get_highlighted_entry_maker_from_quickfix(opts)
end

return M
