return {
  "MeanderingProgrammer/render-markdown.nvim",
  pin = true,
  commit = "c7188a8f9d2953696b6303caccbf39c51fa2c1b1",
  ft = { "markdown", "octo" },
  dependencies = {
    { "nvim-treesitter/nvim-treesitter", pin = true, commit = "4916d6592ede8c07973490d9322f187e07dfefac" },
    { "nvim-tree/nvim-web-devicons", pin = true, commit = "d7462543c9e366c0d196c7f67a945eaaf5d99414" },
  },
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    file_types = { "markdown", "octo" },
    render_modes = { "n", "c", "t" },
    heading = { enabled = false },
    -- link = { enabled = false },
    -- pipe_table = { enabled = false },
    anti_conceal = {
      enabled = false,
    },
  },
}
