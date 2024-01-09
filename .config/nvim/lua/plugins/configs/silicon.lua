---Run silicon visualisation
---@param visible boolean
local function run(visible)
	require("silicon").visualise_api({ visible = visible })
end

return {
	-- NOTE: Author username seems to be changed
	"0oAstro/silicon.lua",
	requires = { "nvim-lua/plenary.nvim" },
	keys = {
		{
			"<C-w><Leader>",
			function()
				run(false)
			end,
			mode = { "v" },
		},
		{
			"<C-w><Leader>",
			function()
				run(true)
			end,
			mode = { "n" },
		},
	},
	config = function()
		require("silicon").setup({
			theme = "TwoDark",
			output = "${year}${month}${date}_${time}.png",
			bgColor = "#FFFFFF00",
			roundCorner = true,
			windowControls = true,
			lineNumber = true,
			font = "FiraCode Nerd Font",
			lineOffset = 1,
			linePad = 2,
			padHoriz = 80,
			padVert = 100,
			shadowBlurRadius = 10,
			shadowColor = "#0000007F",
			shadowOffsetX = 8,
			shadowOffsetY = 8,
			gobble = false,
			debug = false,
		})
	end,
}
