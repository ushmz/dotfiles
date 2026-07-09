local function config()
  require("colorizer").setup({
    "*",
    css = { css = true, css_fn = true, RRGGBBAA = true },
    html = { names = false },
  })
end

return {
  "norcalli/nvim-colorizer.lua",
  pin = true,
  commit = "a065833f35a3a7cc3ef137ac88b5381da2ba302e",
  event = { "BufReadPre" },
  cond = false,
  config = config,
}
