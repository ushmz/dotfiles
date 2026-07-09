return {
  "petertriho/nvim-scrollbar",
  pin = true,
  commit = "f8e87b96cd6362ef8579be456afee3b38fd7e2a8",
  event = { "BufNewFile", "BufRead" },
  dependencies = {
    { "lewis6991/gitsigns.nvim", pin = true, commit = "0f00d07c2c3106ba6abd594ac1c17f211141b7b5" },
    { "kevinhwang91/nvim-hlslens", pin = true, commit = "be2d7b2be01860b5445a007ff2bc72b29896db6b" },
  },
  config = function()
    local colors = require("kanagawa.colors").setup({ theme = "dragon" })
    require("scrollbar").setup({
      max_lines = 2000,
      handle = {
        highlight = "CursorLine",
        hide_if_all_visible = true,
      },
      marks = {
        Cursor = { text = " " },
        Search = { color = colors.palette.dragonYellow },
        Error = { color = colors.palette.dragonRed },
        Warn = { color = colors.palette.dragonYellow },
        Info = { color = colors.palette.dragonGreen2 },
        Hint = { color = colors.palette.dragonBlue },
        Misc = { color = colors.palette.dragonTeal },
      },
      excluded_buftypes = {
        "terminal",
        "popup",
        "nofile",
      },
      handlers = {
        search = true,
      },
    })
    -- require("scrollbar.handlers.gitsigns").setup()
    require("scrollbar.handlers.search").setup({})
  end,
}
