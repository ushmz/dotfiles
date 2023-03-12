local M = {}

---Sets a highlight group with `vim.api.nvim_set_hl()`
---@param name string Highlight group name
---@param val table Highlight definition map
local function set_hl(name, val)
	vim.api.nvim_set_hl(0, name, val)
end

M.red = "#CC6666"
M.magenta = "#CC6666"
M.dark_pink = "#C586C0"
M.pink = "#B5585F"
M.light_pink = "#EED8DA"
M.orange = "#DE935F"
M.dark_yellow = "#D4BB6C"
M.yellow = "#F0C674"
M.green = "#B5BD68"
M.emerald = "#58B5A8"
M.cyan = "#81A2BE" -- "#8aBEB7"
M.cobalt = "#6C8ED4"
M.blue = "#569CD6"
M.light_blue = "#9CDCFE"
M.purple = "#B294BB"
M.gray = "#808080"
M.light_gray = "#C5C8C6"
M.white = "#D4D4D4"
M.black = "#1D1F21"

---Set VSCode-like color theme for completion menu
---Add following value to mvim-cmp `window.completion.winhighlight` option
---| Normal:Pmenu,
---| FloatBorder:Pmenu,
---| CursorLine:PmenuSel,
---| Search:None,
M.set_vscode_menu_hl = function()
	set_hl("Normal", { bg = M.black, fg = M.light_gray })
	set_hl("Pmenu", { bg = M.black, fg = M.light_gray })
	set_hl("PmenuSel", { bg = M.blue, fg = M.white })

	set_hl("CmpItemMenu", { bg = "NONE", fg = M.dark_pink, italic = false })
	set_hl("CmpItemAbbrMatch", { bg = "NONE", fg = M.light_blue })
	set_hl("CmpItemAbbrMatchFuzzy", { link = "CmpItemAbbrMatch" })
	set_hl("CmpItemAbbrDeprecated", { bg = "NONE", fg = M.gray, strikethrough = true })

	set_hl("CmpItemKindField", { bg = M.pink, fg = M.purple })
	set_hl("CmpItemKindProperty", { link = "CmpItemKindField" })
	set_hl("CmpItemKindEvent", { link = "CmpItemKindField" })

	set_hl("CmpItemKindKeyword", { bg = "NONE", fg = M.white })
	set_hl("CmpItemKindText", { link = "CmpItemKindKeyword" })
	set_hl("CmpItemKindEnum", { link = "CmpItemKindKeyword" })

	set_hl("CmpItemKindConstant", { bg = M.red, fg = M.black })
	set_hl("CmpItemKindConstructor", { link = "CmpItemKindConstant" })
	set_hl("CmpItemKindReference", { link = "CmpItemKindConstant" })

	set_hl("CmpItemKindFunction", { bg = "NONE", fg = M.yellow })
	set_hl("CmpItemKindStruct", { link = "CmpItemKindFunction" })
	set_hl("CmpItemKindClass", { link = "CmpItemKindFunction" })
	set_hl("CmpItemKindModule", { link = "CmpItemKindFunction" })
	set_hl("CmpItemKindOperator", { link = "CmpItemKindFunction" })

	set_hl("CmpItemKindVariable", { bg = "NONE", fg = M.purple })
	set_hl("CmpItemKindFile", { link = "CmpItemKindVariable" })

	set_hl("CmpItemKindUnit", { bg = M.dark_yellow, fg = M.black })
	set_hl("CmpItemKindSnippet", { link = "CmpItemKindUnit" })
	set_hl("CmpItemKindFolder", { link = "CmpItemKindUnit" })

	set_hl("CmpItemKindMethod", { bg = M.cobalt, fg = M.black })
	set_hl("CmpItemKindValue", { link = "CmpItemKindFunction" })
	set_hl("CmpItemKindEnumMember", { link = "CmpItemKindFunction" })

	set_hl("CmpItemKindInterface", { bg = M.emerald, fg = M.black })
	set_hl("CmpItemKindColor", { link = "CmpItemKindInterface" })
	set_hl("CmpItemKindTypeParameter", { link = "CmpItemKindInterface" })
	set_hl("CmpItemKindText", { link = "CmpItemKindInterface" })
end

return M
