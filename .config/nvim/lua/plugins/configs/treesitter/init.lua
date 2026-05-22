return {
  {
    "nvim-treesitter/nvim-treesitter",
    pin = true,
    commit = "4916d6592ede8c07973490d9322f187e07dfefac",
    lazy = false,
    build = ":TSUpdate",
    branch = "main",
    config = function()
      require("nvim-treesitter").setup({
        install_dir = vim.fs.joinpath(vim.fn.stdpath("data"), "site"),
      })
      vim.g.skip_ts_context_commentstring_module = true
    end,
  },
  {
    "RRethy/nvim-treesitter-endwise",
    pin = true,
    commit = "8fe8a95630f4f2c72a87ba1927af649e0bfaa244",
    event = { "InsertEnter" },
    dependencies = { { "nvim-treesitter/nvim-treesitter", pin = true, commit = "4916d6592ede8c07973490d9322f187e07dfefac" } },
    config = function()
      require("nvim-treesitter-endwise").init()
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    pin = true,
    commit = "93d60a475f0b08a8eceb99255863977d3a25f310",
    branch = "main",
    dependencies = { { "nvim-treesitter/nvim-treesitter", pin = true, commit = "4916d6592ede8c07973490d9322f187e07dfefac" } },
    event = { "BufEnter" },
    opts = {
      select = {
        lookahead = true,
      },
    },
    config = function()
      require("plugins.configs.treesitter.textobj.select").setup()
      require("plugins.configs.treesitter.textobj.swap").setup()
      require("plugins.configs.treesitter.textobj.move").setup()
      require("plugins.configs.treesitter.textobj.repeat").setup()
    end,
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    pin = true,
    commit = "1b212c2eee76d787bbea6aa5e92a2b534e7b4f8f",
    event = { "BufEnter" },
    dependencies = { { "nvim-treesitter/nvim-treesitter", pin = true, commit = "4916d6592ede8c07973490d9322f187e07dfefac" } },
    config = function()
      require("ts_context_commentstring").setup({
        enable_autocmd = false,
      })

      local get_option = vim.filetype.get_option
      vim.filetype.get_option = function(filetype, option)
        return option == "commentstring" and require("ts_context_commentstring.internal").calculate_commentstring()
          or get_option(filetype, option)
      end
    end,
  },
}
