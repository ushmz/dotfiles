local config = {
	config_file_preferred_name = "cspell.json",

	--- A way to define your own logic to find the CSpell configuration file.
	---@params cwd The same current working directory defined in the source,
	--             defaulting to vim.loop.cwd()
	---@return string|nil The path of the json file
	find_json = function(cwd)
		local local_config = cwd .. "/.cspell.json"
		if vim.fn.filereadable(vim.fn.expand(local_config)) == 1 then
			return local_config
		end

		return vim.fn.expand("~/.config/cspell/cspell.json")
	end,

	-- Will find and read the cspell config file synchronously, as soon as the
	-- code actions generator gets called.
	--
	-- If you experience UI-blocking during the first run of this code action, try
	-- setting this option to false.
	-- See: https://github.com/davidmh/cspell.nvim/issues/25
	read_config_synchronously = true,

	---@param payload AddToJSONSuccess
	on_add_to_json = function(payload)
		os.execute(
			string.format(
				"jq . %s > %s.tmp && mv %s.tmp %s",
				payload.cspell_config_path,
				payload.cspell_config_path,
				payload.cspell_config_path,
				payload.cspell_config_path
			)
		)
	end,
}

local cspell = require("cspell")
return {
	cspell.diagnostics.with({
		config = config,
		diagnostics_postprocess = function(diagnostic)
			-- diagnostic.message = string.format('Unknown word "%s"', diagnostic.user_data.misspelled)
			diagnostic.severity = vim.diagnostic.severity.WARN
		end,
		condition = function()
			return vim.fn.executable("cspell") > 0
		end,
	}),
	cspell.code_actions.with({
		config = config,
		condition = function()
			return vim.fn.executable("cspell") > 0
		end,
	}),
}
