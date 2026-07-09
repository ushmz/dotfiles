local function config()
  require("nvim-web-devicons").setup({
    -- your personnal icons can go here (to override)
    -- DevIcon will be appended to `name`
    override = {},
    -- globally enable default icons (default to false)
    -- will get overriden by `get_icons` option
    default = true,
  })
end

return {
  "nvim-tree/nvim-web-devicons",
  pin = true,
  commit = "d7462543c9e366c0d196c7f67a945eaaf5d99414",
  lazy = true,
  config = config,
}
