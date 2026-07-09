# tsgo-warmup

tsgo (TypeScript 7 native) only searches **already-loaded** projects when finding
references, so cross-package find-references misses packages you haven't opened.
This eagerly loads one file per project so references span the whole workspace.

> [!NOTE]
> A stopgap for tsgo's current behaviour. If tsgo gains eager cross-project
> reference search (as tsserver has), it becomes redundant.

## Usage

Set defaults once, then call `run(root)` when tsgo attaches (see
`lua/plugins/configs/mason-lspconfig.lua`):

```lua
require("tsgo-warmup").setup({ globs = { "packages/*/index.ts" } })

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.name == "tsgo" and client.config.root_dir then
      require("tsgo-warmup").run(client.config.root_dir)
    end
  end,
})
```

## Per-repo config (neoconf)

Overridable per repository via `.neoconf.json` (neoconf wins over `setup`):

```json
{
  "tsgo": {
    "warmup": {
      "enabled": true,
      "rootOnly": true,
      "globs": ["packages/*/index.ts", "apps/worker/src/scripts/**/*.ts"]
    }
  }
}
```

- `enabled` — warm up in this repo (default `false`; opt in per repo)
- `rootOnly` — only when the cwd is the workspace root
- `globs` — one buffer loaded per nearest `tsconfig.json`, so broad globs
  (e.g. `apps/worker/src/**/*.ts`) cost a single buffer per project
