local function config()
  require("nvim-autopairs").setup({
    disable_filetype = { "TelescopePrompt", "vim" },
  })
end

return {
  "windwp/nvim-autopairs",
  pin = true,
  commit = "59bce2eef357189c3305e25bc6dd2d138c1683f5",
  event = { "InsertEnter" },
  dependencies = { { "nvim-treesitter/nvim-treesitter", pin = true, commit = "4916d6592ede8c07973490d9322f187e07dfefac" } },
  config = config,
}
