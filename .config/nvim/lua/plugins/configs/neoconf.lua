return {
  "folke/neoconf.nvim",
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
