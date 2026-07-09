return {
  "numToStr/Comment.nvim",
  pin = true,
  commit = "e30b7f2008e52442154b66f7c519bfd2f1e32acb",
  keys = {
    { "gc", mode = { "n", "x" } },
    { "gb", mode = { "n", "x" } },
    { "gcc", mode = "n" },
  },
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require("Comment").setup({
      pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
    })
  end,
}
