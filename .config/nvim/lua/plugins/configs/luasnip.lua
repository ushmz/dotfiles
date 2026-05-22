local function config()
  -- Keymaps are defined in completion config.
  local snip = require("luasnip")
  require("luasnip.loaders.from_vscode").lazy_load()
  snip.filetype_extend("typescript", { "javascript" })
  snip.filetype_extend("bash", { "zsh" })
  snip.filetype_extend("ruby", { "rails" })

  require("luasnip.loaders.from_lua").lazy_load()
end

return {
  "L3MON4D3/LuaSnip",
  pin = true,
  commit = "73813308abc2eaeff2bc0d3f2f79270c491be9d7",
  dependencies = {
    { "rafamadriz/friendly-snippets", pin = true, commit = "6cd7280adead7f586db6fccbd15d2cac7e2188b9" },
  },
  event = { "InsertEnter" },
  config = config,
}
