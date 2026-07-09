return {
  -- "LunarVim/bigfile.nvim",
  dir = "/Users/ushmz/src/github.com/ushmz/bigfile.nvim",
  pin = true,
  commit = "33eb067e3d7029ac77e081cfe7c45361887a311a",
  lazy = false,
  config = function()
    require("bigfile").setup({
      features = {
        "indent_blankline",
        "illuminate",
        "lsp",
        {
          name = "treesitter",
          disable = function(buf)
            vim.api.nvim_create_autocmd("FileType", {
              buffer = buf,
              once = true,
              callback = function()
                vim.treesitter.stop(buf)
              end,
            })
          end,
          opts = { defer = true },
        },
        "syntax",
        "matchparen",
        "vimopts",
        "filetype",
      },
    })
  end,
}
