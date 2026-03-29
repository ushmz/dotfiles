return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown" },
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    render_modes = { "n", "c" },
    heading = { enabled = false },
    -- link = { enabled = false },
    -- pipe_table = { enabled = false },
  },
}
