local function config()
  require("nvim-surround").setup()
end

return {
  "kylechui/nvim-surround",
  pin = true,
  commit = "19e39478ccf5fa2eefdb3595af2f2927d0ff2416",
  event = { "BufNewFile", "BufRead" },
  config = config,
}
