local function config()
	require("fidget").setup({
		text = {
			spinner = "pipe",
			done = "✔",
			commenced = "Started",
			completed = "Completed",
		},
		align = {
			bottom = true,
			right = true,
		},
		timer = {
			spinner_rate = 125, -- in ms
			fidget_decay = 1000, -- in ms
			task_decay = 500, -- in ms
		},
		window = {
			relative = "win",
			---If you'd like to integrate with colorscheme `catppuccin`,
			---you have to set `0`
			blend = 0,
			zindex = nil,
			border = "none",
		},
		fmt = {
			leftpad = true,
			stack_upwards = true,
			max_width = 0,
			-- function to format fidget title
			fidget = function(fidget_name, spinner)
				return string.format("%s %s", spinner, fidget_name)
			end,
			-- function to format each task line
			task = function(task_name, message, percentage)
				return string.format(
					"%s%s [%s]",
					message,
					percentage and string.format(" (%s%%)", percentage) or "",
					task_name
				)
			end,
		},
		debug = {
			logging = false,
			strict = false,
		},
	})
end

return {
	"j-hui/fidget.nvim",
	event = { "BufRead" },
	config = config,
}
