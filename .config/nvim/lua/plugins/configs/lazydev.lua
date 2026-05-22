return {
  "folke/lazydev.nvim",
  pin = true,
  commit = "ff2cbcba459b637ec3fd165a2be59b7bbaeedf0d",
  ft = { "lua" },
  opts = {
    library = {
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    },
  },
}
