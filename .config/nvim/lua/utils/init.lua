local M = {}

---Return `true` if the plugin should be loaded, otherwise `false`
---@param for_vscode boolean The plugin is needed for VSCode or not
---@return boolean
M.should_loaded = function(for_vscode)
  if not vim.g.vscode then
    return true
  end
  return for_vscode
end

M.flatten = function(tbl)
  return vim.iter(tbl):flatten():totable()
end

---Return the terminal emulator name.
---Inside tmux, `TERM_PROGRAM` is overridden to "tmux", so use
---`#{client_termname}` to get the actual outer terminal's TERM value instead.
---@return string
M.term = function()
  if vim.env.TMUX then
    return vim.fn.system("tmux display-message -p '#{client_termname}'"):gsub("%s+$", "")
  end

  return vim.env.TERM_PROGRAM
end

return M
