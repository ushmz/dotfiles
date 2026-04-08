local M = {}

local function extend_neoconf(key, default_settings)
  local settings = vim.deepcopy(default_settings)

  local ok, neoconf = pcall(require, "neoconf")
  if not ok then
    return settings
  end

  local ok_get, loaded = pcall(neoconf.get, key, settings)
  if not ok_get then
    return settings
  end

  if type(loaded) ~= "table" then
    return settings
  end

  return vim.tbl_deep_extend("force", settings, loaded)
end

M.python_adapter = function()
  return require("neotest-python")({
    -- 	---Extra arguments for nvim-dap configuration
    -- 	---See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
    -- 	dap = { justMyCode = false },
    -- 	---Command line arguments for runner
    -- 	---Can also be a function to return dynamic values
    -- 	args = { "--log-level", "DEBUG" },
    -- 	---Runner to use. Will use pytest if available by default.
    -- 	---@type string | function
    -- 	runner = "pytest",
    -- 	---Custom python path for the runner.
    -- 	---If not provided, the path will be inferred by checking for
    -- 	---virtual envs in the local directory and for Pipenev/Poetry configs
    -- 	---@type string | string[] | function
    -- 	-- python = ".venv/bin/python",
    -- 	---Returns if a given file path is a test file.
    -- 	---NB: This function is called a lot so don't perform any heavy tasks within it.
    -- 	-- is_test_file = function(file_path) end,
    -- pytest_discover_instances = true
  })
end

M.plenary_adapter = function()
  return require("neotest-plenary").setup({
    ---By default, it will glob for:
    ---{ "*/testrc*", "*/minimal_init*", "test*/init.vim" }
    -- min_init = "./path/to/test_init.lua",
  })
end

M.go_adapter = function()
  return require("neotest-go")({
    experimental = { test_table = true },
    args = { "-count=1", "-timeout=60s" },
  })
end

M.jest_adapter = function()
  return require("neotest-jest")({
    jestCommand = "yarn test --runInBand",
    jestConfigFile = "jest.config.ts",
    jest_test_discovery = false,
    env = {
      CI = true,
      NODE_OPTIONS = "--dns-result-order=ipv4first --max_old_space_size=6144",
    },
  })
end

local default_vitest_settings = {
  command = "pnpm test",
  config_file = "vitest.config.ts",
  cwd = ".",
}

local function vitest_settings()
  return extend_neoconf("neotest.vitest", default_vitest_settings)
end

M.vitest_adapter = function()
  local settings = vitest_settings()

  return require("neotest-vitest")({
    vitestCommand = function()
      return settings.command
    end,
    vitestConfigFile = function()
      return settings.config_file
    end,
    cwd = function()
      return settings.cwd
    end,
    vitest_test_discovery = false,
    env = function(spec_env)
      return vim.tbl_extend("force", settings.env or {}, spec_env)
    end,
  })
end

M.playwright_adapter = function()
  return require("neotest-playwright").adapter({
    options = {
      persist_project_selection = true,
      enable_dynamic_test_discovery = true,
    },
  })
end

return M
