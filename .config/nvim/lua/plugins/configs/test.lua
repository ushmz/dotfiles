local function config()
	require("nvim-test").setup({
		run = true,
		commands_create = true,
		filename_modifier = ":.",
		silent = false,
		term = "toggleterm",
		termOpts = {
			---@type "horizontal"|"vertical"|"float"
			direction = "vertical",
			width = 96,
			height = 24,
			go_back = false,
			---@type true|false|"auto"
			stopinsert = "auto",
			keep_one = true,
		},
		runners = {
			cs = "nvim-test.runners.dotnet",
			go = "nvim-test.runners.go-test",
			haskell = "nvim-test.runners.hspec",
			javascriptreact = "nvim-test.runners.jest",
			javascript = "nvim-test.runners.jest",
			lua = "nvim-test.runners.busted",
			python = "nvim-test.runners.pytest",
			ruby = "nvim-test.runners.rspec",
			rust = "nvim-test.runners.cargo-test",
			typescript = "nvim-test.runners.jest",
			typescriptreact = "nvim-test.runners.jest",
		},
	})

	require("nvim-test.runners.jest"):setup({
		command = "~/node_modules/.bin/jest", -- a command to run the test runner
		args = { "--collectCoverage=false" }, -- default arguments
		-- env = { CUSTOM_VAR = "value" }, -- custom environment variables

		file_pattern = "\\v(__tests__/.*|(spec|test))\\.(js|jsx|coffee|ts|tsx)$",
		find_files = { "{name}.test.{ext}", "{name}.spec.{ext}" },

		filename_modifier = nil,
		working_directory = nil,
	})
end

return {
	"klen/nvim-test",
	config = config,
}
