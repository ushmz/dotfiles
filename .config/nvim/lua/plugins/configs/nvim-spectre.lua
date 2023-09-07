local function config()
	require("spectre").setup({
		mapping = {
			["send_to_qf"] = {
				map = [[\q]],
				cmd = function()
					require("spectre.actions").send_to_qf()
				end,
				desc = "nvim-spectre: Send all items to [Q]uickfix",
			},
			["replace_cmd"] = {
				map = [[\c]],
				cmd = function()
					require("spectre.actions").replace_cmd()
				end,
				desc = "nvim-spectre: Input replace [C]ommand",
			},
			["show_option_menu"] = {
				map = [[\o]],
				cmd = function()
					require("spectre").show_options()
				end,
				desc = "nvim-spectre: Show [O]ptions",
			},
			["run_current_replace"] = {
				map = [[\rc]],
				cmd = function()
					require("spectre.actions").run_current_replace()
				end,
				desc = "nvim-spectre: [R]eplace [C]urrent line",
			},
			["run_replace"] = {
				map = [[\R]],
				cmd = function()
					require("spectre.actions").run_replace()
				end,
				desc = "nvim-spectre: [R]eplace all",
			},
			["change_view_mode"] = {
				map = [[\v]],
				cmd = function()
					require("spectre").change_view()
				end,
				desc = "nvim-spectre: Change result [V]iew mode",
			},
			["change_replace_sed"] = {
				map = "trs",
				cmd = function()
					require("spectre").change_engine_replace("sed")
				end,
				desc = "nvim-spectre: Use sed to replace",
			},
			["change_replace_oxi"] = {
				map = "tro",
				cmd = function()
					require("spectre").change_engine_replace("oxi")
				end,
				desc = "nvim-spectre: Use oxi to replace",
			},
			["toggle_live_update"] = {
				map = "tu",
				cmd = function()
					require("spectre").toggle_live_update()
				end,
				desc = "nvim-spectre: Update when vim writes to file",
			},
			["toggle_ignore_case"] = {
				map = "ti",
				cmd = function()
					require("spectre").change_options("ignore-case")
				end,
				desc = "nvim-spectre: [T]oggle [I]gnore case",
			},
			["toggle_ignore_hidden"] = {
				map = "th",
				cmd = function()
					require("spectre").change_options("hidden")
				end,
				desc = "nvim-spectre: [T]oggle search [H]idden",
			},
			["resume_last_search"] = {
				map = [[\l]],
				cmd = function()
					require("spectre").resume_last_search()
				end,
				desc = "nvim-spectre: [R]epeat last search",
			},
		},
	})
end

return {
	"nvim-pack/nvim-spectre",
	keys = {
		{
			[[\S"]],
			function()
				require("spectre").toggle()
			end,
			mode = "n",
			desc = "Toggle Spectre",
		},
		{
			[[\sw]],
			function()
				require("spectre").open_visual({ select_word = true })
			end,
			mode = "n",
			desc = "Search current word",
		},
		{
			[[\\sw]],
			function()
				vim.fn.execute("normal!")
				require("spectre").open_visual()
			end,
			mode = "v",
			desc = "Search current word",
		},
		{
			[[\\sp]],
			function()
				require("spectre").open_file_search({ select_word = true })
			end,
			mode = "n",
			desc = "Search on current file",
		},
	},
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
	},
	config = config,
}
