return {
  "3rd/image.nvim",
  lazy = false,
  -- so that it doesn't build the rock
  -- @see https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
  build = false,
  cond = function()
    local term = require("utils").term()
    return vim.tbl_contains({ "xterm-ghostty", "xterm-kitty" }, term)
  end,
  opts = {
    processor = "magick_cli",
    integrations = {
      markdown = {
        clear_in_insert_mode = true,
        only_render_image_at_cursor = false,
        only_render_image_at_cursor_mode = "inline",
      },
      asciidoc = {
        clear_in_insert_mode = true,
        only_render_image_at_cursor = false,
        only_render_image_at_cursor_mode = "inline",
      },
    },
  },
}
