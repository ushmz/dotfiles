local sep = require("plenary.path").path.sep

---Spacer item for the picker.
local spacer = " "

---Separator item with highlight for the picker.
local separator = { ":", "Comment" }

---Return the default icon and its width.
---@return string icon
---@return number width
local function default_icon()
	local icon = require("nvim-web-devicons").get_icon("fname", { default = true })
	local width = require("plenary.strings").strdisplaywidth(icon)
	return icon, width
end

---Strip the leading and trailing whitespace from a string.
---@param str string
---@return string # The stripped string.
local function strip(str)
	return string.match(str, "^%s*(.-)%s*$")
end

local function strip_and_refresh_position(str, start_, end_)
	local leading, text, _ = string.match(str, "^(%s*)(.-)(%s*)$")
	local new_start = start_ - #leading
	local new_end = end_ - #leading
	return text, new_start, new_end
end

---Find the first whitespace in a string.
---@param str string
---@return number # The offset of the first whitespace.
local function find_whitespace(str)
	local offset = 0
	for i = 1, #str do
		if string.sub(str, i, i) == " " then
			offset = i
			break
		end
	end
	return offset
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
---@return string directory # Directory path to display
local function get_path_and_tail(file_path)
	local tail = require("telescope.utils").path_tail(file_path)
	local path_without_tail = require("plenary.strings").truncate(file_path, #file_path - #tail, "")
	local directory = require("telescope.utils").transform_path({ path_display = { "truncate" } }, path_without_tail)

	return tail, directory
end

---Get the highlighted entry maker for the file picker.
---Put the file name first and the dimmed parent directory path in the second.
---@param opts? table
---@return function
local function pretty_file_entry_maker(opts)
	local _, icon_width = default_icon()
	local displayer = require("telescope.pickers.entry_display").create({
		separator = " ",
		items = {
			{ width = icon_width },
			{ width = nil },
			{ remaining = true },
		},
	})

	return function(line)
		local entry_make = require("telescope.make_entry").gen_from_file(opts or {})
		local entry = entry_make(line)

		entry.display = function(et)
			local tail, directory_path = get_path_and_tail(et.value)
			local icon, iconhl = require("telescope.utils").get_devicons(tail)

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
---Grouping the matched lines by file name.
---@class PrettyVimgrepEntryMakerProps
---@field cwd string # The current working directory.
---@field heading boolean # Whether to show the heading.
---@field directory_hl string # The highlight group for the directory path (default: `Directory`)
---@field filename_hl string # The highlight group for the file name (default: `Title`)
---@field lnum_hl string # The highlight group for the line number (default: `Number`)
---@field col_hl string # The highlight group for the column number (default: `Number`)
---@param opts PrettyVimgrepEntryMakerProps
---@return function
local function pretty_vimgrep_entry_maker(opts)
	return function(line)
		local e = vim.json.decode(line)
		if not e then
			return nil
		end

		if e.type and e.type == "begin" then
			if not opts.heading then
				return nil
			end

			local suffix = string.format(" %s", string.rep("─", 120))
			local filepath = e.data.path.text
			local filename = require("telescope.utils").transform_path({ cwd = opts.cwd }, filepath)
			local tail = require("telescope.utils").path_tail(filename)
			local display, hl_group = require("telescope.utils").transform_devicons(filename, filename .. suffix, false)
			local offset = find_whitespace(display)
			local end_directory = offset + (#filename - #tail)
			local end_filename = end_directory + #tail
			local end_suffix = end_filename + #suffix

			return {
				value = filepath,
				ordinal = filepath,
				filename = filepath,
				path = opts.cwd .. sep .. filepath,
				kind = e.type,
				display = function(_)
					if hl_group then
						return display,
							{
								{ { 0, offset }, hl_group },
								{ { offset, end_directory }, opts.directory_hl or "Directory" },
								{ { end_directory, end_filename }, opts.filename_hl or "Normal" },
								{ { end_filename, end_suffix }, "Normal" },
							}
					else
						return display
					end
				end,
			}
		elseif e.type and e.type == "match" then
			local text = e.data.lines.text
			if not text then
				return nil
			end

			local submatches = e.data.submatches
			local start_pos = not vim.tbl_isempty(submatches) and submatches[1].start or 0
			local end_pos = not vim.tbl_isempty(submatches) and submatches[1]["end"] or 0
			local filename = e.data.path.text
			local lnum = e.data.line_number
			local col = start_pos + 1
			local title = opts.heading and "" or filename
			local text_, start_, end_ = strip_and_refresh_position(text, start_pos, end_pos)
			local display = string.format("%s%s:%s %s", title, lnum, col, text_)
			local lnum_end = #title + #tostring(lnum)
			local col_end = lnum_end + 1 + #tostring(col)
			local matched_start = col_end + 1 + start_
			local matched_end = col_end + 1 + end_

			return {
				filename = filename,
				path = opts.cwd .. sep .. filename,
				lnum = lnum,
				text = text,
				col = col,
				value = e.data,
				ordinal = string.format("%s:%s:%s:%s", filename, lnum, col, text),
				kind = e.type,
				display = function(_)
					local hl_group = {
						{ { 0, #title }, "Title" },
						{ { #title, lnum_end }, "Number" },
						{ { lnum_end, lnum_end + 1 }, "Comment" },
						{ { lnum_end + 1, col_end }, "Number" },
						{ { col_end + 1, matched_start }, "Comment" },
						{ { matched_start, matched_end }, "TelescopeMatching" },
						{ { matched_end, col_end + #text }, "Comment" },
					}
					return display, hl_group
				end,
			}
		else
			return
		end
	end
end

---Get the highlighted entry maker for the grep picker.
---Applied a different highlight to the parent directory path,
---added row(line) and column number, and dimmed the matched line text.
---@param opts? table
---@return function
local function vimgrep_entry_maker(opts)
	local _, icon_width = default_icon()
	local displayer = require("telescope.pickers.entry_display").create({
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
		local entry_maker = require("telescope.make_entry").gen_from_vimgrep(opts or {})
		local entry = entry_maker(line)

		entry.display = function(et)
			local filepath, row, col, text = get_path_and_pos(et.value, ":")
			local filename, directory_path = get_path_and_tail(filepath)
			local icon, iconhl = require("telescope.utils").get_devicons(filename)

			return displayer({
				{ icon, iconhl },
				spacer,
				{ directory_path .. "/", "Directory" },
				{ filename, nil },
				separator,
				{ row, "Number" },
				separator,
				{ col, "Number" },
				spacer,
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
local function pretty_quickfix_entry_maker(opts)
	local _, icon_width = default_icon()
	local displayer = require("telescope.pickers.entry_display").create({
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
		local entry_maker = require("telescope.make_entry").gen_from_quickfix(opts or {})
		local entry = entry_maker(input)

		entry.display = function(et)
			local filepath = vim.F.if_nil(et.filename, et.bufname)
			local filename, directory_path = get_path_and_tail(filepath)
			local icon, iconhl = require("telescope.utils").get_devicons(filename)

			return displayer({
				{ icon, iconhl },
				spacer,
				{ directory_path .. "/", "Directory" },
				{ filename, nil },
				separator,
				{ tostring(et.lnum), "Number" },
				separator,
				{ tostring(et.col), "Number" },
				spacer,
				{ strip(et.text), "Comment" },
			})
		end
		return entry
	end
end

local M = {}

---Create a new entry maker for the file picker.
---@see https://github.com/nvim-telescope/telescope.nvim/issues/2014#issuecomment-1541063264
---@param opts? any
---@return function
function M.find_files(opts)
	return pretty_file_entry_maker(opts)
end

---Create a new entry maker for the old file picker.
---@param opts? any
---@return function
function M.old_files(opts)
	return pretty_file_entry_maker(opts)
end

---Create a new entry maker for the grep picker.
---@param opts? table
---@return function
function M.live_grep(opts)
	return vimgrep_entry_maker(opts)
end

---Create a new entry maker for the grouped grep picker.
---@param opts PrettyVimgrepEntryMakerProps
---@return function
function M.pretty_live_grep(opts)
	local opts = opts or {}
	opts.cwd = opts.cwd or vim.loop.cwd()
	opts.heading = opts.heading or true
	opts.directory_hl = opts.directory_hl or "Directory"
	opts.filename_hl = opts.filename_hl or "Normal"
	opts.lnum_hl = opts.lnum_hl or "Number"
	opts.col_hl = opts.col_hl or "Number"
	return pretty_vimgrep_entry_maker(opts or {})
end

---Create a new entry maker for the lsp_references picker.
---@param opts? table
---@return function
function M.lsp_references(opts)
	return pretty_quickfix_entry_maker(opts)
end

---Create a new entry maker for the lsp_implementations picker.
---@param opts? table
---@return function
function M.lsp_implementations(opts)
	return pretty_quickfix_entry_maker(opts)
end

return M
