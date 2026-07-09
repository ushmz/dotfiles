local function config()
  require("js-teleporter").setup({
    test_roots = { "__test__", "__tests__", "test", "tests" },
  })
end

return {
  "ushmz/js-teleporter.nvim",
  pin = true,
  commit = "cc83efc0edf2076a7a68d18efeccde07a74bb5c2",
  ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  dependencies = {
    { "nvim-lua/plenary.nvim", pin = true, commit = "b9fd5226c2f76c951fc8ed5923d85e4de065e509" },
  },
  config = config,
}
