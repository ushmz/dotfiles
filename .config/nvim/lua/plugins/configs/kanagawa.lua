return {
  "rebelot/kanagawa.nvim",
  pin = true,
  commit = "aef7f5cec0a40dbe7f3304214850c472e2264b10",
  lazy = false,
  config = function()
    require("kanagawa").setup({
      compile = true,
      undercurl = false,
      commentStyle = { italic = false },
      functionStyle = {},
      keywordStyle = { italic = false },
      statementStyle = { bold = true },
      typeStyle = {},
      transparent = false,
      dimInactive = true,
      terminalColors = true,
      colors = {
        palette = {},
        theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
      },
      overrides = function(colors)
        local theme = colors.theme
        return {
          TelescopeTitle = { fg = "#87AFAF", bg = theme.ui.bg_dim, bold = true },
          TelescopePromptNormal = { bg = theme.ui.bg_dim },
          TelescopePromptBorder = { fg = theme.ui.special, bg = theme.ui.bg_dim },
          TelescopeResultsNormal = { bg = theme.ui.bg_dim },
          TelescopeResultsBorder = { fg = theme.ui.special, bg = theme.ui.bg_dim },
          TelescopePreviewNormal = { bg = theme.ui.bg_dim },
          TelescopePreviewBorder = { fg = theme.ui.special, bg = theme.ui.bg_dim },
        }
      end,
      theme = "dragon",
      background = {
        dark = "dragon",
        light = "lotus",
      },
    })

    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "kanagawa",
      callback = function()
        local theme = "Kanagawa"
        if vim.o.background == "light" then
          theme = "Kanagawa_light"
        elseif vim.o.background == "dark" then
          theme = "Kanagawa_dragon"
        end

        vim.schedule(function()
          vim.system({ "kitty", "+kitten", "themes", theme }, { detach = true })
        end)
      end,
    })
    vim.cmd("colorscheme kanagawa")
  end,
}
