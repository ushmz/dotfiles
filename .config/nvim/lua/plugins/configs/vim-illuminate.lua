return {
  "RRethy/vim-illuminate",
  pin = true,
  commit = "0d1e93684da00ab7c057410fecfc24f434698898",
  event = { "CursorHold" },
  config = function()
    require("illuminate").configure({
      filetypes_denylist = {
        "cmp_docs",
        "cmp_menu",
        "dirvish",
        "fugitive",
        "lazy",
        "markdown",
        "noice",
        "prompt",
        "TelescopePrompt",
      },
    })
    vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "CursorLine" })
    vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "CursorLine" })
    -- vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "CursorLine"})
  end,
}
