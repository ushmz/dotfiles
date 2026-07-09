-- tsgo-warmup
-- tsgo (TypeScript 7 native) only searches already-loaded projects when finding
-- references, so cross-package find-references misses packages you have not
-- opened yet. This eagerly loads one file per project (in hidden buffers) so
-- their programs load and references span the whole workspace.
--
-- NOTE: a stopgap for tsgo's current behaviour. If tsgo gains eager cross-project
-- reference search (as tsserver has), it becomes redundant.
local M = {}

local defaults = {
  enabled = false,
  globs = { "packages/*/index.ts" },
  root_only = false,
}

local opts = defaults
local warmed = {}

---@param user table|nil
function M.setup(user)
  opts = vim.tbl_extend("force", defaults, user or {})
end

-- Merge the setup() defaults with per-repo overrides from neoconf
-- (`.neoconf.json` -> `tsgo.warmup`). neoconf wins where it sets a value.
local function resolve()
  local enabled, globs, root_only = opts.enabled, opts.globs, opts.root_only
  local ok, neoconf = pcall(require, "neoconf")
  if ok then
    local ok_get, cfg = pcall(neoconf.get, "tsgo.warmup", {})
    if ok_get and type(cfg) == "table" then
      if type(cfg.enabled) == "boolean" then
        enabled = cfg.enabled
      end
      if type(cfg.globs) == "table" and #cfg.globs > 0 then
        globs = cfg.globs
      end
      if type(cfg.rootOnly) == "boolean" then
        root_only = cfg.rootOnly
      end
    end
  end
  return enabled, globs, root_only
end

---Load one file per project (nearest tsconfig) under the configured globs, so
---broad globs (e.g. `apps/worker/src/**/*.ts`) still cost a single buffer per
---project. Runs at most once per workspace root.
---@param root string The workspace root
function M.run(root)
  if not root or warmed[root] then
    return
  end
  local enabled, globs, root_only = resolve()
  if not enabled then
    return
  end
  if root_only and vim.fn.getcwd() ~= root then
    return
  end
  warmed[root] = true
  vim.schedule(function()
    local seen = {}
    for _, glob in ipairs(globs) do
      for _, path in ipairs(vim.fn.glob(root .. "/" .. glob, true, true)) do
        local project = vim.fs.root(path, { "tsconfig.json" }) or vim.fs.dirname(path)
        if not seen[project] then
          seen[project] = true
          local bufnr = vim.fn.bufadd(path)
          vim.fn.bufload(bufnr)
          vim.bo[bufnr].buflisted = false
        end
      end
    end
  end)
end

return M
