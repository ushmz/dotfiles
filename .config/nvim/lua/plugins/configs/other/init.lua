local function config()
  require("other-nvim").setup({
    mappings = {
      "rails",
      "golang",
      {
        pattern = "(.*).ts",
        target = "%1",
        transformer = "jest",
        context = "jest",
      },
      {
        pattern = "(.*).test.ts",
        target = "%1",
        transformer = "jest",
        context = "jest",
      },
    },
    transformers = {
      jest = require("plugins.configs.other.transformer").jest,
    },
    style = {
      border = "rounded",
      seperator = "|",
      width = 0.7,
      minHeight = 5,
    },
  })
end

return {
  "rgroli/other.nvim",
  pin = true,
  commit = "1d48e090f6d1d53dda9fb5094af3f2006ebbb858",
  -- cond = false,
  cmd = { "Other", "OtherTabNew", "OtherSplit", "OtherVSplit", "OtherClear" },
  config = config,
}
