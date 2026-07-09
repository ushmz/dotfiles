return {
  "Wansmer/treesj",
  pin = true,
  commit = "26bc2a8432ba3ea79ed6aa346fba780a3d372570",
  keys = { "<space>j" },
  dependencies = { { "nvim-treesitter/nvim-treesitter", pin = true, commit = "4916d6592ede8c07973490d9322f187e07dfefac" } },
  config = function()
    require("treesj").setup({
      use_default_keymaps = false,
    })

    vim.keymap.set("n", "<space>j", require("treesj").toggle)
  end,
}
