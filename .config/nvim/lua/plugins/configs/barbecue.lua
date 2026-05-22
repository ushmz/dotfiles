local function config()
  require("barbecue").setup({
    attach_navic = false,
    create_autocmd = false,
    show_modified = true,
  })
  vim.api.nvim_create_autocmd({
    "WinScrolled",
    "WinResized",
    "BufWinEnter",
    "CursorHold",
    "InsertLeave",
    -- include this if you have set `show_modified` to `true`
    "BufModifiedSet",
  }, {
    group = vim.api.nvim_create_augroup("barbecue.updater", {}),
    callback = function()
      require("barbecue.ui").update()
    end,
  })

  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local buf = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client.server_capabilities.documentSymbolProvider then
        require("nvim-navic").attach(client, buf)
      end
    end,
  })
end

return {
  "utilyre/barbecue.nvim",
  name = "barbecue",
  pin = true,
  commit = "3e31404f0b93a2c30d151abf0648650ac811c664",
  event = { "BufRead", "BufNewFile" },
  dependencies = {
    { "SmiteshP/nvim-navic", pin = true, commit = "f5eba192f39b453675d115351808bd51276d9de5" },
    { "nvim-tree/nvim-web-devicons", pin = true, commit = "d7462543c9e366c0d196c7f67a945eaaf5d99414" },
  },
  config = config,
}
