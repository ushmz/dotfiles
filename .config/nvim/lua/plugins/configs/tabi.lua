return {
  "ushmz/tabi.nvim",
  pin = true,
  commit = "ba532aa5b0ee2fa685b95495a7da96b4f2b97bb5",
  cmd = { "Tabi" },
  ---@type TabiOptions
  opts = {
    ui = {
      selector = "telescope",
      note_preview_length = 80,
    },
    keymaps = {
      enabled = false,
    },
  },
}
