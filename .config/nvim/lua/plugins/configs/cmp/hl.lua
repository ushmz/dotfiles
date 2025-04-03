local M = {}

---Set highlight colors for completion menu
---Add following value to mvim-cmp `window.completion.winhighlight` option
---| Normal:Pmenu,
---| CursorLine:PmenuSel,
---| Search:None,
M.set = function()
	local colors = require("kanagawa.colors").setup({ theme = "dragon" })
	local set_hl = require("theme").set_hl

	set_hl("Pmenu", { link = "Normal" })
	set_hl("PmenuSel", { bg = colors.palette.dragonBlue, fg = colors.palette.dragonBlack1 })
	set_hl("FloatBorder", { fg = colors.palette.dragonWhite })

	set_hl("CmpItemMenu", { bg = "NONE", fg = colors.palette.dragonViolet, italic = false })
	set_hl("CmpItemAbbrMatch", { bg = "NONE", fg = colors.palette.dragonViolet })
	set_hl("CmpItemAbbrMatchFuzzy", { link = "CmpItemAbbrMatch" })
	set_hl("CmpItemAbbrDeprecated", { bg = "NONE", fg = colors.palette.dragonGray, strikethrough = true })

	set_hl("CmpItemKindField", { bg = colors.palette.dragonRed, fg = colors.palette.dragonBlack1 })
	set_hl("CmpItemKindProperty", { link = "CmpItemKindField" })
	set_hl("CmpItemKindEvent", { link = "CmpItemKindField" })

	set_hl("CmpItemKindKeyword", { bg = "NONE", fg = colors.palette.dragonWhite })
	set_hl("CmpItemKindText", { link = "CmpItemKindKeyword" })
	set_hl("CmpItemKindEnum", { link = "CmpItemKindKeyword" })

	set_hl("CmpItemKindConstant", { bg = colors.palette.dragonRed, fg = colors.palette.dragonBlack1 })
	set_hl("CmpItemKindConstructor", { link = "CmpItemKindConstant" })
	set_hl("CmpItemKindReference", { link = "CmpItemKindConstant" })

	set_hl("CmpItemKindFunction", { bg = "NONE", fg = colors.palette.dragonYellow })
	set_hl("CmpItemKindStruct", { link = "CmpItemKindFunction" })
	set_hl("CmpItemKindClass", { link = "CmpItemKindFunction" })
	set_hl("CmpItemKindModule", { link = "CmpItemKindFunction" })
	set_hl("CmpItemKindOperator", { link = "CmpItemKindFunction" })

	set_hl("CmpItemKindVariable", { bg = "NONE", fg = colors.palette.dragonYellow })
	set_hl("CmpItemKindFile", { link = "CmpItemKindVariable" })

	set_hl("CmpItemKindUnit", { bg = colors.palette.dragonYellow, fg = colors.palette.dragonBlack1 })
	set_hl("CmpItemKindSnippet", { link = "CmpItemKindUnit" })
	set_hl("CmpItemKindFolder", { link = "CmpItemKindUnit" })

	set_hl("CmpItemKindMethod", { bg = colors.palette.dragonViolet, fg = colors.palette.dragonBlack1 })
	set_hl("CmpItemKindValue", { link = "CmpItemKindFunction" })
	set_hl("CmpItemKindEnumMember", { link = "CmpItemKindFunction" })

	set_hl("CmpItemKindInterface", { bg = colors.palette.dragonGreen2, fg = colors.palette.dragonBlack1 })
	set_hl("CmpItemKindColor", { link = "CmpItemKindInterface" })
	set_hl("CmpItemKindTypeParameter", { link = "CmpItemKindInterface" })
	set_hl("CmpItemKindText", { link = "CmpItemKindInterface" })
end

return M
