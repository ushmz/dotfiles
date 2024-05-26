local M = {}

---Set highlight colors for completion menu
---Add following value to mvim-cmp `window.completion.winhighlight` option
---| Normal:Pmenu,
---| CursorLine:PmenuSel,
---| Search:None,
M.set = function()
	local colors = require("theme").colors
	local set_hl = require("theme").set_hl

	set_hl("Pmenu", { link = "Normal" })
	set_hl("PmenuSel", { bg = colors.blue, fg = colors.black })
	set_hl("FloatBorder", { fg = colors.white })

	set_hl("CmpItemMenu", { bg = "NONE", fg = colors.purple, italic = false })
	set_hl("CmpItemAbbrMatch", { bg = "NONE", fg = colors.purple })
	set_hl("CmpItemAbbrMatchFuzzy", { link = "CmpItemAbbrMatch" })
	set_hl("CmpItemAbbrDeprecated", { bg = "NONE", fg = colors.gray, strikethrough = true })

	set_hl("CmpItemKindField", { bg = colors.red, fg = colors.purple })
	set_hl("CmpItemKindProperty", { link = "CmpItemKindField" })
	set_hl("CmpItemKindEvent", { link = "CmpItemKindField" })

	set_hl("CmpItemKindKeyword", { bg = "NONE", fg = colors.white })
	set_hl("CmpItemKindText", { link = "CmpItemKindKeyword" })
	set_hl("CmpItemKindEnum", { link = "CmpItemKindKeyword" })

	set_hl("CmpItemKindConstant", { bg = colors.red, fg = colors.black })
	set_hl("CmpItemKindConstructor", { link = "CmpItemKindConstant" })
	set_hl("CmpItemKindReference", { link = "CmpItemKindConstant" })

	set_hl("CmpItemKindFunction", { bg = "NONE", fg = colors.yellow })
	set_hl("CmpItemKindStruct", { link = "CmpItemKindFunction" })
	set_hl("CmpItemKindClass", { link = "CmpItemKindFunction" })
	set_hl("CmpItemKindModule", { link = "CmpItemKindFunction" })
	set_hl("CmpItemKindOperator", { link = "CmpItemKindFunction" })

	set_hl("CmpItemKindVariable", { bg = "NONE", fg = colors.purple })
	set_hl("CmpItemKindFile", { link = "CmpItemKindVariable" })

	set_hl("CmpItemKindUnit", { bg = colors.yellow, fg = colors.black })
	set_hl("CmpItemKindSnippet", { link = "CmpItemKindUnit" })
	set_hl("CmpItemKindFolder", { link = "CmpItemKindUnit" })

	set_hl("CmpItemKindMethod", { bg = colors.purple, fg = colors.black })
	set_hl("CmpItemKindValue", { link = "CmpItemKindFunction" })
	set_hl("CmpItemKindEnumMember", { link = "CmpItemKindFunction" })

	set_hl("CmpItemKindInterface", { bg = colors.green, fg = colors.black })
	set_hl("CmpItemKindColor", { link = "CmpItemKindInterface" })
	set_hl("CmpItemKindTypeParameter", { link = "CmpItemKindInterface" })
	set_hl("CmpItemKindText", { link = "CmpItemKindInterface" })
end

return M
