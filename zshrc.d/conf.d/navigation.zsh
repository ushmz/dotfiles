# Omit `cd`
setopt auto_cd
setopt auto_pushd
setopt pushd_silent

map ...='cd ../../'
map ....='cd ../../../'

# cdr: recent directories
autoload -Uz chpwd_recent_dirs cdr
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':completion:*' recent-dirs-insert both
zstyle ':chpwd:*' recent-dirs-max 500
zstyle ':chpwd:*' recent-dirs-default true
zstyle ':chpwd:*' recent-dirs-file "${XDG_CACHE_HOME}/shell/chpwd-recent-dirs"
zstyle ':chpwd:*' recent-dirs-pushd true
[[ -d ${XDG_CACHE_HOME}/shell ]] || mkdir -p ${XDG_CACHE_HOME}/shell

if has zoxide; then
    cache_init zoxide init zsh && source ${REPLY}
fi

if has fzf; then
    # cd into a subdirectory
    function fcd() {
        local dir=$(find . -type d | fzf +m)
        [[ -n ${dir} ]] && cd -- ${dir}
    }

    # cd into a recent directory
    function fcdr() {
        local dir=$(cdr -l | sed -e 's/^[[:digit:]]*[[:blank:]]*//' | fzf +m)
        [[ -n ${dir} ]] && cd -- ${dir/#\~/${HOME}}
    }
fi
