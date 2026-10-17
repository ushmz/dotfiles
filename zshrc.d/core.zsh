# Helpers and preconditions shared by conf.d/*.zsh.
# Only put things here that two or more topics need. No topic configuration.

autoload -Uz add-zsh-hook

# Select the emacs keymap before anyone calls `bindkey`.
# (zsh links `main` to viins when $EDITOR contains "vi")
bindkey -e

# has <command>: true if the command is on PATH
function has() {
    (( $+commands[$1] ))
}

ZSH_CACHE_DIR=${XDG_CACHE_HOME}/zsh

# Topics register completions by adding to fpath. compinit runs in finalize.zsh.
typeset -U fpath
fpath=(
    ${HOMEBREW_PREFIX:+${HOMEBREW_PREFIX}/share/zsh/site-functions}(N-/)
    ${fpath}
)

# zsh-abbr
if [[ -r ${HOMEBREW_PREFIX}/share/zsh-abbr/zsh-abbr.zsh ]]; then
    fpath=(${HOMEBREW_PREFIX}/share/zsh-abbr ${fpath})
    source ${HOMEBREW_PREFIX}/share/zsh-abbr/zsh-abbr.zsh
fi

# map <name>=<expansion>: register an abbreviation, or an alias without zsh-abbr
function map() {
    if (( $+functions[abbr] )); then
        abbr -S -q --force "$@" &>/dev/null
    else
        alias "$@"
    fi
}

# cache_init <command> <args...>
# Cache the output of `<command> <args...>` (e.g. `zoxide init zsh`) and set
# REPLY to the cache file. It is regenerated when the command is upgraded.
# Source $REPLY at the top level, not inside a function, so that variables
# declared by the script do not become function-local.
#
#   cache_init zoxide init zsh && source $REPLY
function cache_init() {
    local bin=${commands[$1]:A}
    [[ -n ${bin} ]] || return 1

    REPLY=${ZSH_CACHE_DIR}/init/${1}.zsh
    if [[ ! -s ${REPLY} || ! ${REPLY} -nt ${bin} || ! -r ${REPLY}.src || "$(<${REPLY}.src)" != ${bin} ]]; then
        [[ -d ${REPLY:h} ]] || mkdir -p ${REPLY:h}
        "$@" >| ${REPLY}.tmp && mv -f ${REPLY}.tmp ${REPLY} && print -r -- ${bin} >| ${REPLY}.src || return 1
    fi
}
