local M = {}

local base_config = {
	type = "ruby",
	request = "attach",
	options = { source_filetype = "ruby" },
	error_on_failure = true,
	localfs = true,
}

local run_config = vim.tbl_extend("force", base_config, { waiting = 1000, random_port = true })

M.configurations = {
	vim.tbl_extend("force", base_config, { name = "Attach existing process", port = 38698 }),
	vim.tbl_extend("force", base_config, { name = "Attach random port" }),
	vim.tbl_extend("force", run_config, { name = "Run rails", command = "bundle", args = { "exec", "rails", "server" } }),
	vim.tbl_extend("force", run_config, { name = "bin/dev", command = "bin/dev" }),
	vim.tbl_extend("force", run_config, { name = "[TODO] Run current file" }),
	vim.tbl_extend("force", run_config, { name = "[TODO] Run rspec current file" }),
	vim.tbl_extend("force", run_config, { name = "[TODO] Run rspec current line" }),
	vim.tbl_extend("force", run_config, { name = "[TODO] Run rspec" }),
}

M.adapter = function(callback, config)
	local server = config.server or "127.0.0.1"
	local port = config.port or math.random(49152, 65535)

	local args = { "compose", "exec", "-it", "coe_web" }

	if config.command then
		for arg in config.command:gmatch("%S+") do
			table.insert(args, arg)
		end
	end

	if config.args then
		for _, arg in ipairs(config.args) do
			for part in arg:gmatch("%S+") do
				table.insert(args, part)
			end
		end
	end

	print(vim.inspect(args))

	vim.defer_fn(function()
		callback({
			type = "server",
			host = server,
			port = port,
			executable = {
				command = "docker",
				args = args,
			},
		})
	end, 10000)
end

return M
