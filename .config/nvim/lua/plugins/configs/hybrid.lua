local red = "#CC6666"
local yellow = "#F0C674"
local green = "#B5BD68"
local cyan = "#8aBEB7"
local blue = "#81A2BE"
local purple = "#B294BB"
local gray = "#808080"
local white = "#D4D4D4"
local black = "#1D1F21"

---If you'd like to use mode rich colors,
---please refer following palette.
-- local magenta = "#B5585F"
-- local pink = "#C586C0"
-- local orange = "#DE935F"
-- local dark_yellow = "#D4BB6C"
-- local emerald = "#58B5A8"
-- local cobalt = "#6C8ED4"
-- local light_blue = "#9CDCFE"
-- local dark_gray = "#282A2E"
-- local light_gray = "#C5C8C6"

---Sets a highlight with `vim.api.nvim_set_hl()`
---@param name string Highlight group name
---@param val table Highlight definition map
local function set_hl(name, val)
	vim.api.nvim_set_hl(0, name, val)
end

---Set diagnostic highlight colors
local function set_diagnostic_colors()
	set_hl("DiagnosticError", { fg = red })
	set_hl("DiagnosticWarn", { fg = yellow })
	set_hl("DiagnosticHint", { fg = cyan })
	set_hl("DiagnosticInfo", { fg = green })
end

---Set highlight colors for completion menu
---Add following value to mvim-cmp `window.completion.winhighlight` option
---| Normal:Pmenu,
---| CursorLine:PmenuSel,
---| Search:None,
local function set_completion_menu_hl()
	set_hl("Normal", { bg = black, fg = white })
	set_hl("Pmenu", { bg = black, fg = white })
	set_hl("PmenuSel", { bg = blue, fg = black })
	set_hl("FloatBorder", { fg = white })

	set_hl("CmpItemMenu", { bg = "NONE", fg = purple, italic = false })
	set_hl("CmpItemAbbrMatch", { bg = "NONE", fg = purple })
	set_hl("CmpItemAbbrMatchFuzzy", { link = "CmpItemAbbrMatch" })
	set_hl("CmpItemAbbrDeprecated", { bg = "NONE", fg = gray, strikethrough = true })

	set_hl("CmpItemKindField", { bg = red, fg = purple })
	set_hl("CmpItemKindProperty", { link = "CmpItemKindField" })
	set_hl("CmpItemKindEvent", { link = "CmpItemKindField" })

	set_hl("CmpItemKindKeyword", { bg = "NONE", fg = white })
	set_hl("CmpItemKindText", { link = "CmpItemKindKeyword" })
	set_hl("CmpItemKindEnum", { link = "CmpItemKindKeyword" })

	set_hl("CmpItemKindConstant", { bg = red, fg = black })
	set_hl("CmpItemKindConstructor", { link = "CmpItemKindConstant" })
	set_hl("CmpItemKindReference", { link = "CmpItemKindConstant" })

	set_hl("CmpItemKindFunction", { bg = "NONE", fg = yellow })
	set_hl("CmpItemKindStruct", { link = "CmpItemKindFunction" })
	set_hl("CmpItemKindClass", { link = "CmpItemKindFunction" })
	set_hl("CmpItemKindModule", { link = "CmpItemKindFunction" })
	set_hl("CmpItemKindOperator", { link = "CmpItemKindFunction" })

	set_hl("CmpItemKindVariable", { bg = "NONE", fg = purple })
	set_hl("CmpItemKindFile", { link = "CmpItemKindVariable" })

	set_hl("CmpItemKindUnit", { bg = yellow, fg = black })
	set_hl("CmpItemKindSnippet", { link = "CmpItemKindUnit" })
	set_hl("CmpItemKindFolder", { link = "CmpItemKindUnit" })

	set_hl("CmpItemKindMethod", { bg = purple, fg = black })
	set_hl("CmpItemKindValue", { link = "CmpItemKindFunction" })
	set_hl("CmpItemKindEnumMember", { link = "CmpItemKindFunction" })

	set_hl("CmpItemKindInterface", { bg = green, fg = black })
	set_hl("CmpItemKindColor", { link = "CmpItemKindInterface" })
	set_hl("CmpItemKindTypeParameter", { link = "CmpItemKindInterface" })
	set_hl("CmpItemKindText", { link = "CmpItemKindInterface" })
end

return {
	"w0ng/vim-hybrid",
	config = function()
		vim.cmd("syntax on")
		vim.opt.background = "dark"
		vim.api.nvim_set_var("hybrid_use_term_colors", 1)
		vim.api.nvim_set_var("hybrid_reduced_contrast", 0)

		vim.api.nvim_create_autocmd({ "VimEnter" }, {
			nested = true,
			callback = function()
				vim.cmd.colorscheme("hybrid")
				set_diagnostic_colors()
				set_completion_menu_hl()
			end,
		})
	end,
}
