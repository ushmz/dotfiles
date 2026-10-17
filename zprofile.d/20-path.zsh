# Homebrew: exports HOMEBREW_PREFIX and prepends its bin to PATH
if [[ -x /opt/homebrew/bin/brew ]]; then
	eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /home/linuxbrew/.linuxbrew/bin/brew ]]; then
	eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# `brew shellenv` exports FPATH, which leaks version-specific function
# directories into child shells and breaks them after a zsh upgrade.
# fpath is managed by zshrc.d/core.zsh instead.
typeset +x FPATH

# -U: keep only the first occurrence of each duplicated value
# ref. http://zsh.sourceforge.net/Doc/Release/Shell-Builtin-Commands.html#index-typeset
typeset -U PATH path MANPATH manpath

# ignore /etc/zprofile, /etc/zshrc, /etc/zlogin, and /etc/zlogout
# ref. http://zsh.sourceforge.net/Doc/Release/Files.html
# ref. http://zsh.sourceforge.net/Doc/Release/Options.html#index-GLOBALRCS
# unsetopt GLOBAL_RCS

# If you'd like to trust `/etc` configuration, you have to source following
# source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh

path=(
    # asdf
    "${ASDF_DATA_DIR:-$HOME/.asdf}/shims"(N-/)
    # local packages
    "${HOME}/.local/bin"(N-/)
    # GOBIN
    ${GOBIN}(N-/)
    # cargo
    "${CARGO_HOME}/bin"(N-/)
    # exenv
    "${HOME}/.exenv/bin"(N-/)
    # Android SDK
    "${ANDROID_HOME}/emulator"(N-/)
    "${ANDROID_HOME}/tools"(N-/)
    "${ANDROID_HOME}/tools/bin"(N-/)
    "${ANDROID_HOME}/platform-tools"(N-/)
    # react-native
    "/usr/local/share/npm/bin"(N-/)
    "${HOME}/node_modules/.bin"(N-/)

    # Rancher Desktop
    "${HOME}/.rd/bin"(N-/)

    # dotfiles commands
    "${DOTFILES}/bin"(N-/)
    # git subcommands
    "${DOTFILES}/.config/git/aliases"(N-/)

    ${path}
)

# Exports that need the final PATH
export TMUX_SHELL=${commands[zsh]}

if (( $+commands[src-hilite-lesspipe.sh] )); then
    export LESSOPEN="| ${commands[src-hilite-lesspipe.sh]} %s"
fi
