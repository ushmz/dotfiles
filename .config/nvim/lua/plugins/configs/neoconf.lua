return {
  "folke/neoconf.nvim",
  pin = true,
  commit = "60b088f2104a73b30f5319faa3d0a92a7b85f9f7",
  -- It's important that you set up neoconf.nvim BEFORE nvim-lspconfig.
  lazy = false,
  opts = {
    import = {
      vscode = true,
      coc = false,
      nlsp = false,
    },
  },
}
