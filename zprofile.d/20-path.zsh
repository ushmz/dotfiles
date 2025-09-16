# -U: keep only the first occurrence of each duplicated value
# ref. http://zsh.sourceforge.net/Doc/Release/Shell-Builtin-Commands.html#index-typeset
typeset -U PATH path MANPATH manpath

# ignore /etc/zprofile, /etc/zshrc, /etc/zlogin, and /etc/zlogout
# ref. http://zsh.sourceforge.net/Doc/Release/Files.html
# ref. http://zsh.sourceforge.net/Doc/Release/Options.html#index-GLOBALRCS
unsetopt GLOBAL_RCS

path=(
    # GNU/Linux commands
    "/usr/local/opt/coreutils/libexec/gnubin"(N-/) # coreutils
    "/usr/local/opt/ed/libexec/gnubin"(N-/) # ed
    "/usr/local/opt/findutils/libexec/gnubin"(N-/) # findutils
    "/usr/local/opt/gnu-sed/libexec/gnubin"(N-/) # sed
    "/usr/local/opt/gnu-tar/libexec/gnubin"(N-/) # tar
    "/usr/local/opt/grep/libexec/gnubin"(N-/) # grep

    # asdf
    "${ASDF_DATA_DIR:-$HOME}/.asdf/shims"(N-/)
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

    # git subcommands
    "${HOME}/dotfiles/.config/git/aliases"(N-/)

    ${path}
)

manpath=(
    # coreutils
    "/usr/local/opt/coreutils/libexec/gnuman"(N-/)
    # ed
    "/usr/local/opt/ed/libexec/gnuman"(N-/)
    # findutils
    "/usr/local/opt/findutils/libexec/gnuman"(N-/)
    # sed
    "/usr/local/opt/gnu-sed/libexec/gnuman"(N-/)
    # tar
    "/usr/local/opt/gnu-tar/libexec/gnuman"(N-/)
    # grep
    "/usr/local/opt/grep/libexec/gnuman"(N-/)
    ${manpath}
)
