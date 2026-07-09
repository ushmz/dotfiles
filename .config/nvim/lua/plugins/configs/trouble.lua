return {
  "folke/trouble.nvim",
  pin = true,
  commit = "bd67efe408d4816e25e8491cc5ad4088e708a69a",
  cmd = { "Trouble" },
  dependencies = { { "nvim-tree/nvim-web-devicons", pin = true, commit = "d7462543c9e366c0d196c7f67a945eaaf5d99414" } },
  ---@source https://github.com/folke/trouble.nvim#setup
  opts = {
    position = "left",
  },
  event = { "VeryLazy" },
}
