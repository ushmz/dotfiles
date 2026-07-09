local function config()
  require("nvim-ts-autotag").setup({
    opts = {
      enable_close_on_slash = true,
    },
  })
end

return {
  "windwp/nvim-ts-autotag",
  pin = true,
  commit = "8e1c0a389f20bf7f5b0dd0e00306c1247bda2595",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { { "nvim-treesitter/nvim-treesitter", pin = true, commit = "4916d6592ede8c07973490d9322f187e07dfefac" } },
  config = config,
}
