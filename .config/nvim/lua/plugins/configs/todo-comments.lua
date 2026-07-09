return {
  "folke/todo-comments.nvim",
  pin = true,
  commit = "31e3c38ce9b29781e4422fc0322eb0a21f4e8668",
  dependencies = { { "nvim-lua/plenary.nvim", pin = true, commit = "b9fd5226c2f76c951fc8ed5923d85e4de065e509" } },
  cmd = { "TodoTrouble", "TodoQuickFix", "TodoTelescope" },
  event = { "BufNewFile", "BufRead" },
  config = function()
    local colors = require("kanagawa.colors").setup({ theme = "dragon" })

    -- NOTE: Disable treesitter comment highlights to let todo-comments.nvim handle them
    local comment_hls = { "@comment.todo", "@comment.note", "@comment.warning", "@comment.error" }
    for _, hl in ipairs(comment_hls) do
      vim.api.nvim_set_hl(0, hl, {})
    end

    require("todo-comments").setup({
      keywords = {
        FIX = { icon = " ", color = colors.palette.dragonRed, alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
        TODO = { icon = " ", color = colors.palette.dragonGreen2, alt = { "TODO" } },
        HACK = { icon = " ", color = colors.palette.dragonYellow, alt = { "HELPME" } },
        WARN = { icon = " ", color = colors.palette.dragonYellow, alt = { "WARNING" } },
        NOTE = { icon = "󰏫", color = colors.palette.dragonBlue, alt = { "INFO" } },
        TEST = { icon = " ", color = colors.palette.dragonViolet, alt = { "TESTING", "PASSED", "FAILED" } },
        QUESTION = { icon = "", color = colors.palette.dragonTeal, alt = { "QUESTION" } },
      },
      gui_style = {
        fg = "BOLD",
      },
      highlight = {
        multiline = true,
        before = "",
        keyword = "fg",
        after = "",
        pattern = { [[.*<(KEYWORDS)\s*:?]], [[.*\[<(KEYWORDS)\]\s*:*?]] },
      },
    })
  end,
}
