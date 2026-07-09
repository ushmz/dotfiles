local function config()
  require("ibl").setup({ scope = { show_exact_scope = true } })
end

return {
  "lukas-reineke/indent-blankline.nvim",
  pin = true,
  commit = "d28a3f70721c79e3c5f6693057ae929f3d9c0a03",
  main = "ibl",
  event = { "BufNewFile", "BufRead" },
  config = config,
}
