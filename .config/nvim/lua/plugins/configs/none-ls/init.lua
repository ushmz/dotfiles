local function config()
  local extras = require("plugins.configs.none-ls.extra")
  local prettier = require("plugins.configs.none-ls.prettier")
  local gofmt = require("plugins.configs.none-ls.gofmt")
  local stylua = require("plugins.configs.none-ls.stylua")

  require("null-ls").setup({
    sources = {
      unpack(prettier),
      unpack(gofmt),
      unpack(stylua),
      unpack(extras),
    },
  })

  vim.api.nvim_create_user_command("NullLsToggle", function(args)
    local fargs = args.fargs
    if #fargs ~= 1 then
      vim.api.nvim_err_writeln("Invalid number of arguments: " .. #fargs .. ", expected 1")
      return
    end

    require("null-ls").toggle({ name = fargs[1] })
  end, { nargs = "*", desc = "Toggle null-ls" })
end

return {
  "nvimtools/none-ls.nvim",
  pin = true,
  commit = "c9317c2a8629d4e39e7cf47be74cb67f3ab37cda",
  ft = { "*" },
  dependencies = {
    { "nvimtools/none-ls-extras.nvim", pin = true, commit = "c6fa39ac52814182c05552cb5d3750cae23ff0f0" },
    { "davidmh/cspell.nvim", pin = true, commit = "5feecef8d109f5460c576596aba44a6253127aa4" },
  },
  config = config,
}
