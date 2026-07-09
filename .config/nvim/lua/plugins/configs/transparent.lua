return {
  "xiyaowong/transparent.nvim",
  pin = true,
  cond = function()
    local loaded, neoconf = pcall(require, "neoconf")
    if not loaded then
      return false
    end

    local ok, enabled = pcall(neoconf.get, "transparent.enabled")
    if not ok then
      return false
    end

    return enabled
  end,
  commit = "8ac59883de84e9cd1850ea25cf087031c5ba7d54",
  event = { "UIEnter" },
  cmd = {
    "TransparentEnable",
    "TransparentDisable",
    "TransparentToggle",
  },
}
