return {
  "kevinhwang91/nvim-bqf",
  pin = true,
  commit = "f65fba733268ffcf9c5b8ac381287eca7c223422",
  event = { "VeryLazy" },
  config = function()
    require("bqf").setup({
      auto_enable = true,
      func_map = {
        vsplit = "",
      },
    })
  end,
}
