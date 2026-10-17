# zshrc

## Structure

```
zshrc.d/
├── .zshrc        # loader: core → conf.d/* → finalize → local
├── core.zsh      # helpers shared by every topic (has, map, cache_init, add-zsh-hook, bindkey -e)
├── conf.d/       # one file per topic
├── finalize.zsh  # compinit and zle plugins (the only order-sensitive place)
└── local.zsh     # machine-local overrides (gitignored)
```

Environment variables and PATH live in `../zprofile.d/`.
Commands that do not need to change the shell state (cd, BUFFER, env, source) live in `../bin/` as executables.

## Rules

1. A `conf.d/*.zsh` file may depend only on zprofile (env/PATH) and `core.zsh`, never on another `conf.d` file.
   Files are not numbered on purpose: their load order must not matter.
2. Each file guards its own prerequisites, e.g. `has git || return` at the top.
3. `conf.d` must not run `compinit`/`compdef`. Register completions by adding to `fpath`; `finalize.zsh` runs `compinit` once.
4. Anything that must be loaded last goes to `finalize.zsh`.
5. Move a helper to `core.zsh` only when two or more topics need it. No topic configuration in `core.zsh`.

`make check` verifies syntax and rule 3.

### Caching `eval "$(tool init zsh)"`

```zsh
cache_init zoxide init zsh && source ${REPLY}
```

The output is cached in `$XDG_CACHE_HOME/zsh/init/` and regenerated when the command is upgraded.
Remove that directory to force regeneration.

## slack notify

Notify you in slack on finish commands that takes long time.

### Setup

```shell
echo 'export SLACK_NOTIFY_WEBHOOK_URL="{workspace webhook URL}"' >> ~/.zshenv
echo 'export SLACK_NOTIFY_USER_NAME="{slackID to notify(mention)}"' >> ~/.zshenv
```
