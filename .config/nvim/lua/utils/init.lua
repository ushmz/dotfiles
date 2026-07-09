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

---Find the local tsgo (TypeScript 7 native) binary by walking up from the
---directory `dir`. In a pnpm monorepo `tsgo` lives only in the workspace root
---`node_modules`, so a per-package lookup is not enough.
---@param dir string Directory to start searching from
---@return string|nil bin The tsgo binary path, or `nil` when unavailable
---@return string|nil owner The directory that owns `node_modules/tsgo`
M.tsgo_bin_from = function(dir)
  -- `dir .. "/_"` makes `dir` itself the first element yielded.
  for d in vim.fs.parents(dir .. "/_") do
    for _, rel in ipairs({ "/node_modules/tsgo/bin/tsc", "/node_modules/.bin/tsgo" }) do
      if vim.uv.fs_stat(d .. rel) then
        return d .. rel, d
      end
    end
  end
  return nil
end

---Find the local tsgo (TypeScript 7 native) binary by walking up from the
---buffer's directory.
---@param bufnr integer|nil
---@return string|nil bin The tsgo binary path, or `nil` when unavailable
---@return string|nil owner The directory that owns `node_modules/tsgo`
M.tsgo_bin = function(bufnr)
  local fname = vim.api.nvim_buf_get_name(bufnr or 0)
  local start = fname ~= "" and vim.fs.dirname(fname) or vim.fn.getcwd()
  return M.tsgo_bin_from(start)
end

---Resolve the TypeScript project root for a buffer: prefer the nearest package
---(tsconfig/jsconfig/package.json) so each monorepo package resolves its own
---tsconfig, else fall back to the monorepo root.
---@param bufnr integer
---@return string|nil
M.ts_root = function(bufnr)
  return vim.fs.root(bufnr, { "tsconfig.json", "jsconfig.json", "package.json" })
    or vim.fs.root(bufnr, { "turbo.json", "turbo.jsonc", "pnpm-workspace.yaml", ".git" })
end

---Decide which TypeScript server should run for a buffer: "tsgo" or "vtsls".
---Global default is `vim.g.ts_server` (falls back to "tsgo"); a repo can override
---it via the `typescript.server` neoconf setting. When "tsgo" is chosen but no
---tsgo binary exists in the repo, falls back to "vtsls".
---@param bufnr integer|nil
---@return "tsgo"|"vtsls"
M.ts_server = function(bufnr)
  local pref = vim.g.ts_server or "tsgo"
  local ok, neoconf = pcall(require, "neoconf")
  if ok then
    local ok_get, v = pcall(neoconf.get, "typescript.server", nil)
    if v == "tsgo" or v == "vtsls" then
      pref = v
    end
  end
  if pref == "tsgo" and not M.tsgo_bin(bufnr) then
    return "vtsls"
  end
  return pref
end

---Return the terminal emulator name.
---Inside tmux, `TERM_PROGRAM` is overridden to "tmux", so use
---`#{client_termname}` to get the actual outer terminal's TERM value instead.
---@return string
M.term = function()
  if vim.env.TMUX then
    local term, _ = vim.fn.system("tmux display-message -p '#{client_termname}'"):gsub("%s+$", "")
    return term
  end

  return vim.env.TERM
end

return M
