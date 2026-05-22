local function config()
  require("modes").setup({
    colors = {
      copy = "#F0C674",
      delete = "#CC6666",
      insert = "#D4D4D4",
      visual = "#B294BB",
    },
    line_opacity = 0.25,
    set_cursor = true,
    set_cursorline = false,
    set_number = false,
    ignore = { "TelescopePrompt" },
  })
end

return {
  "mvllow/modes.nvim",
  pin = true,
  commit = "2badf8771dbb2d1e1066fd6a5dddaad2fc836e72",
  event = { "ModeChanged" },
  config = config,
}
