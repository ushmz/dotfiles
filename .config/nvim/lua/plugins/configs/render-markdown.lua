return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown", "octo" },
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    file_types = { "markdown", "octo" },
    render_modes = { "n", "c" },
    heading = { enabled = false },
    -- link = { enabled = false },
    -- pipe_table = { enabled = false },
  },
}
