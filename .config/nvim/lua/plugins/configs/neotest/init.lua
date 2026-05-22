local adapters = require("plugins.configs.neotest.adapters")
local hl = require("plugins.configs.neotest.hl")

local function config()
  -- require("neodev").setup({
  -- 	library = { plugins = { "neotest" }, types = true },
  -- })
  require("neotest").setup({
    -- [TODO] Can load depends on current filetype?
    adapters = {
      adapters.plenary_adapter(),
      adapters.go_adapter(),
      adapters.jest_adapter(),
      adapters.playwright_adapter(),
      adapters.vitest_adapter(),
    },
    discovery = { enable = false },
  })
  hl.set()
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "neotest-summary",
    callback = function()
      vim.opt_local.cursorline = true
      vim.opt_local.winhighlight:append("CursorLine:NeotestCursorLine")
    end,
  })
end

local function test_nearest(strategy)
  local opt = {}
  if strategy then
    opt[strategy] = "dap"
  end
  require("neotest").run.run(opt)
end

local function test_file(file, strategy)
  local opt = { file or vim.fn.expand("%") }
  if strategy then
    opt[strategy] = "dap"
  end
  require("neotest").run.run(opt)
end

local function test_directory(directory, strategy)
  local opt = { directory or vim.fn.fnamemodify(vim.fn.expand("%"), ":h") }
  if strategy then
    opt[strategy] = "dap"
  end
  require("neotest").run.run(opt)
end

local function test_suite(project_root, strategy)
  local opt = { project_root or vim.fn.getcwd() }
  if strategy then
    opt[strategy] = "dap"
  end
  require("neotest").run.run(opt)
end

local function test_stop()
  require("neotest").run.stop()
end

local function test_attach()
  require("neotest").run.attach()
end

return {
  {
    "nvim-neotest/neotest",
    pin = true,
    commit = "6dd5fb1517107e653f420a6e614618ed13c77e33",
    dependencies = {
      { "nvim-lua/plenary.nvim", pin = true, commit = "b9fd5226c2f76c951fc8ed5923d85e4de065e509" },
      { "nvim-treesitter/nvim-treesitter", pin = true, commit = "4916d6592ede8c07973490d9322f187e07dfefac" },
      ---@see https://github.com/antoinemadec/FixCursorHold.nvim/issues/13
      { "antoinemadec/FixCursorHold.nvim", pin = true, commit = "1900f89dc17c603eec29960f57c00bd9ae696495" },
      --[[ ft = { "python" } ]]
      { "nvim-neotest/neotest-python", pin = true, commit = "b0d3a861bd85689d8ed73f0590c47963a7eb1bf9" },
      -- [[ ft = { "lua" } ]]
      { "nvim-neotest/neotest-plenary", pin = true, commit = "3523adcf9ffaad1911960c5813b0136c1b63a2ec" },
      -- [[ ft = { "go" } ]]
      { "nvim-neotest/neotest-go", pin = true, commit = "59b50505053f9c45a9febb79e11a56206c3e3901" },
      -- ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" }
      { "nvim-neotest/neotest-jest", pin = true, commit = "3f0cc2cff1ee05394081805c622dc2551b54d8c4" },
      -- ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" }
      { "thenbe/neotest-playwright", pin = true, commit = "6266945039dac27a354de33d2f2a66e75485d5e9" },
      { "marilari88/neotest-vitest", pin = true, commit = "f01addc6f07b79ef1be5f4297eafbee9e0959018" },
    },
    keys = {
      { "<leader>tn", test_nearest, mode = "n", desc = "Neotest: Run the [N]earest test" },
      { "<leader>tb", test_file, mode = "n", desc = "Neotest: Run test for a file on current [B]uffer" },
      { "<leader>td", test_directory, mode = "n", desc = "Neotest: Run [T]est for current [D]irectory" },
      { "<leader>tt", test_suite, mode = "n", desc = "Neotest: Run full [T]est suite" },
      { "<leader>tq", test_stop, mode = "n", desc = "Neotest: [S]top running test" },
      { "<leader>ta", test_attach, mode = "n", desc = "Neotest: [A]ttach to the nearest test" },
      {
        "<leader>to",
        function()
          require("neotest").output_panel.toggle({})
        end,
        mode = "n",
        desc = "Neotest: Toggle [O]utput",
      },
      {
        "<leader>ts",
        function()
          require("neotest").summary.toggle()
        end,
        mode = "n",
        desc = "Neotest: Toggle [S]ummary",
      },
      -- { "<leader>tw", test_file, mode = "n", desc = "neotest: Run [T]est in watch mode" },
      -- [TODO] Debug
      -- { "<leader>tn", test_function, mode = "n", desc = "Neotest: Run the nearest [T]est" },
      -- { "<leader>tb", test_file, mode = "n", desc = "Neotest: Run [T]est for a file on current [B]uffer" },
      -- { "<leader>td", test_directory, mode = "n", desc = "Neotest: Run [T]est for current [D]irectory" },
      -- { "<leader>tt", test_suite, mode = "n", desc = "Neotest: Run full [T]est suite" },
    },
    config = function()
      config()
    end,
  },
}
