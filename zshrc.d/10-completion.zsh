# Highlighting completion
zstyle ':completion:*:default' menu select=2

zstyle ':completion:*' verbose yes
# zstyle ':completion:*' completer _complete
# zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*' completer _expand _complete _match _approximate _list _history
zstyle ':completion:*' format '%B%F{blue}%d%f%b'
zstyle ':completion:*:messages' format '%F{YELLOW}%d'$DEFAULT
zstyle ':completion:*:warnings' format '%F{RED}No matches for:''%F{YELLOW} %d'$DEFAULT
# zstyle ':completion:*:descriptions' format '%F{YELLOW}completing %B%d%b'$DEFAULT
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:descriptions' format '%F{yellow}Completing %B%d%b%f'$DEFAULT

# Display matches individually
zstyle ':completion:*' group-name ''

# Use separator
zstyle ':completion:*' list-separator '-->'

# Use same color on auto-complete of zsh
if [ -n "$LS_COLORS" ]; then
    zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
fi

# Use section order in completion of `man` command
zstyle ':completion:*:manuals' separate-sections true

# Completing subscripts of variable
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# Use cache
zstyle ':completion:*' use-cache true
zstyle ':completion:*' cache-path ~/.cache/zsh_cache

# Ignore current directory when use `cd ../<TAB>`
zstyle ':completion:*:cd:*' ignore-parents parent pwd

if [[ -n $(echo ${^fpath}/chpwd_recent_dirs(N)) && -n $(echo ${^fpath}/cdr(N)) ]]; then
    # Enable `cdr`
    autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
    add-zsh-hook chpwd chpwd_recent_dirs
    # `cdr` settings
    zstyle ':completion:*' recent-dirs-insert both
    zstyle ':chpwd:*' recent-dirs-max 500
    zstyle ':chpwd:*' recent-dirs-default true
    # DO NOT forget to make this directory
    zstyle ':chpwd:*' recent-dirs-file "$HOME/.cache/shell/chpwd-recent-dirs"
    zstyle ':chpwd:*' recent-dirs-pushd true
fi

# Ignore intermediate files in `cd` command
zstyle ':completion:*:*files' ignored-patterns '*?.o' '*?~' '*\#'

zstyle ':zle:*' word-chars "*?_.~-=&!#$%^(){}[]<>./;:@,| "
#zstyle ':zle:*' word-chars ' /=;@:{}[]()<>,|.'
zstyle ':zle:*' word-style unspecified
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' keep-prefix
zstyle ':completion:*' recent-dirs-insert both
zstyle ':completion:*:sudo:*' command-path /usr/bin

autoload -Uz compinit && compinit -d ${XDG_STATE_HOME}/.zcompdump
autoload -Uz colors && colors

# less command highlighting
LESSPIPE=`which src-hilite-lesspipe.sh`
export LESSOPEN="| ${LESSPIPE} %s"
export LESS='-R'

# Enable asdf tab complation
fpath+=${ASDF_DATA_DIR}/completions
# Enable poetry auto completion
fpath+=${XDG_CONFIG_HOME}/poetry/.zfunc/_poetry
# Enable gh completion config
if type gh &>/dev/null; then
    eval "$(gh completion -s zsh)"
fi

if type pipx &>/dev/null; then
    eval "$(register-python-argcomplete pipx)"
fi

if type brew &>/dev/null; then
    FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi
