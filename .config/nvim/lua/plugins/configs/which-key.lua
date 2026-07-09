return {
  "folke/which-key.nvim",
  pin = true,
  commit = "3aab2147e74890957785941f0c1ad87d0a44c15a",
  event = "VeryLazy",
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "which-key: Show buffer local Keymaps",
    },
  },
}
