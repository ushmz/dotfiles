# Zsh configuration

How the zsh config in this repository is organized, the rules that keep it maintainable, and the pitfalls behind those rules.

## Startup order

For an interactive login shell (a new terminal window or tmux pane), zsh reads:

```
~/.zshenv            # unmanaged, machine-local (secrets such as SLACK_NOTIFY_*)
/etc/zprofile        # macOS path_helper
~/.zprofile          # -> zprofile.d/.zprofile
/etc/zshrc           # macOS defaults: HIST*, key bindings, nix
~/.zshrc             # -> zshrc.d/.zshrc
```

`/etc/zshrc` runs **after** zprofile, so anything it sets (e.g. `HISTFILE`, `HISTSIZE`, `SAVEHIST`) must be configured in zshrc, not zprofile.

## Layout

```
zprofile.d/                 # environment, read once per login
├── .zprofile               # loader; exports $DOTFILES (resolved through the symlink)
├── 10-env.zsh              # static exports only: no commands, no conditionals
└── 20-path.zsh             # brew shellenv -> path -> exports that need the final PATH

zshrc.d/                    # interactive shell
├── .zshrc                  # loader: core -> conf.d/* -> finalize -> local
├── core.zsh                # helpers shared by every topic (no configuration)
├── conf.d/                 # one file per topic, unnumbered
│   ├── commands.zsh        # GNU replacements, ls/eza, rm -i, nvim, LS_COLORS
│   ├── completion.zsh      # zstyle and completion options
│   ├── devcontainer.zsh
│   ├── direnv.zsh
│   ├── docker.zsh
│   ├── git.zsh             # gh abbreviations, worktree helpers, ghq (^g)
│   ├── history.zsh         # HIST*, history options, atuin
│   ├── navigation.zsh      # auto_cd, cdr, zoxide, fcd/fcdr
│   ├── notify.zsh          # slack notification for long-running commands
│   ├── prompt.zsh          # starship
│   ├── python.zsh          # venv, poetry completion
│   ├── search.zsh          # aliases for bin/googleit, bin/guguru
│   └── shell.zsh           # general options, keys, abbreviations for this config
├── finalize.zsh            # compinit and zle plugins: the only order-sensitive file
└── local.zsh               # machine-local overrides (gitignored)

bin/                        # standalone commands, on PATH via 20-path.zsh
```

`zprofile.d/` is numbered because it is a linear pipeline. `zshrc.d/conf.d/` is unnumbered so that its load order cannot be relied on.

## Rules

1. **A `conf.d/*.zsh` file may depend only on zprofile (env/PATH) and `core.zsh`.**
   Never on another `conf.d` file, and never on load order.
2. **Each file guards its own prerequisites.** Start with `has <command> || return` when the whole topic needs a command.
3. **`conf.d` must not run `compinit` or `compdef`.** Register completions by adding to `fpath`. `finalize.zsh` runs `compinit` once, after every topic has added to `fpath`.
4. **Anything that must load last goes to `finalize.zsh`.** That includes compinit and plugins that wrap zle widgets (autopair, syntax-highlighting, autosuggestions).
5. **Only shared helpers go to `core.zsh`**, and only once two or more topics need them. No topic configuration in `core.zsh`.
6. **Keep a function in zshrc only when it must change the shell state**: `cd`, `BUFFER`/zle widgets, `source`, or setting variables. Everything else is an executable in `bin/`.
7. **`10-env.zsh` holds static exports only.** Exports that need a command or the final PATH go to the bottom of `20-path.zsh`.

`make check` verifies the syntax of all shell files and rule 3.

## core.zsh helpers

| Helper | Use |
|---|---|
| `has <command>` | True if the command is on PATH (no fork) |
| `map <name>=<expansion>` | Register a zsh-abbr abbreviation, or an alias when zsh-abbr is missing |
| `cache_init <command> <args...>` | Cache the output of `<command> <args...>` and set `REPLY` to the file |
| `add-zsh-hook` | Autoloaded once here |

`core.zsh` also runs `bindkey -e` before any topic calls `bindkey` (see pitfalls).

### cache_init

Replaces `eval "$(tool init zsh)"`, which forks the tool on every startup:

```zsh
cache_init zoxide init zsh && source ${REPLY}
```

- The output is cached in `$XDG_CACHE_HOME/zsh/init/<command>.zsh`.
- It is regenerated when the command's resolved path changes (e.g. a Homebrew upgrade moves it to a new Cellar directory) or the binary is newer than the cache.
- Source `$REPLY` at the top level of the file, not inside a function, so that variables declared by the script do not become function-local.
- Remove `$XDG_CACHE_HOME/zsh/init/` to force regeneration.

## Adding things

### A new topic

Create `zshrc.d/conf.d/<topic>.zsh`:

```zsh
has foo || return

map f='foo --bar'
fpath+=(${XDG_DATA_HOME}/foo/completions(N-/))
cache_init foo init zsh && source ${REPLY}
```

Then run `make check`.

### A new command

If it does not need to change the shell state, add an executable script to `bin/` (with a shebang and a one-line usage comment) instead of a shell function. Commands that share code can dispatch on `${0##*/}` with symlinks (see `bin/branch`, `bin/stash`).

### Environment variables

- Needed by child processes and fixed at login: `zprofile.d/10-env.zsh`.
- Needs a command or the final PATH: bottom of `zprofile.d/20-path.zsh`.
- Only meaningful to the interactive shell (e.g. `HISTFILE`): the topic file in `conf.d/`.
- Secrets: `~/.zshenv` (not managed by this repository).

## Pitfalls

These caused real bugs and are the reasons behind the rules above.

- **compinit must run after every fpath addition.** zsh-completions was once added to fpath after compinit and silently did nothing. (Rule 3)
- **`/etc/zshrc` overrides zprofile.** It resets `HISTFILE`/`HISTSIZE`/`SAVEHIST`, so history went to `~/.zsh_history` with 2000 entries. History settings live in `conf.d/history.zsh`.
- **`$EDITOR=nvim` makes zsh pick the vi keymap.** Bindings made before `bindkey -e` land in viins and disappear. `core.zsh` selects emacs first. `/etc/zshrc` still binds Home/End/Delete before that, so `shell.zsh` rebinds them.
- **zsh-autopair takes over the space key**, which breaks zsh-abbr expansion. `finalize.zsh` gives space back to zsh-abbr after `autopair-init`.
- **`brew shellenv` exports `FPATH`.** Child shells and long-lived tmux servers inherit a version-specific path such as `.../Cellar/zsh/5.9/...`. After a zsh upgrade that path no longer exists and `compinit`/`add-zsh-hook` fail to load. `20-path.zsh` unexports `FPATH`. An already-running tmux server keeps its old environment: restart it with `tmux kill-server`.
- **Interactive-only init in zprofile.** atuin/zoxide were initialized in zprofile, so non-login interactive shells did not get them. Shell integrations belong to zshrc.
- **GNU tools are not put on PATH.** `gnubin` on PATH would change `sed`/`grep` for every script (e.g. `sed -i ''` breaks). GNU versions are used only interactively, via abbreviations in `conf.d/commands.zsh`.

## Slack notify

`conf.d/notify.zsh` posts to slack when a command that ran longer than `SLACK_NOTIF_THRESHOLD` seconds (default 180) finishes.

```shell
echo 'export SLACK_NOTIFY_WEBHOOK_URL="{workspace webhook URL}"' >> ~/.zshenv
echo 'export SLACK_NOTIFY_USER_NAME="{slackID to notify(mention)}"' >> ~/.zshenv
```

`make link` asks for these values and writes them.
