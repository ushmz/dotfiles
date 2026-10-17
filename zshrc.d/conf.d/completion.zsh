# Completion styles and options. compinit itself runs in finalize.zsh.

# Auto completing brackets
setopt auto_param_keys

# Completing after `=` in command line arguments
setopt magic_equal_subst

# Force completing in cursor position
setopt complete_in_word

# zsh completions for linux
fpath=(${XDG_CACHE_HOME}/zsh-completions/src(N-/) ${fpath})

# Highlighting completion
zstyle ':completion:*:default' menu select=2

zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _expand _complete _match _approximate _list _history
zstyle ':completion:*' format '%B%F{blue}%d%f%b'
zstyle ':completion:*:messages' format '%F{yellow}%d%f'
zstyle ':completion:*:warnings' format '%F{red}No matches for:%F{yellow} %d%f'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:descriptions' format '%F{yellow}Completing %B%d%b%f'

# Display matches individually
zstyle ':completion:*' group-name ''

# Use separator
zstyle ':completion:*' list-separator '-->'

# Use section order in completion of `man` command
zstyle ':completion:*:manuals' separate-sections true

# Completing subscripts of variable
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# Use cache
zstyle ':completion:*' use-cache true
zstyle ':completion:*' cache-path ${XDG_CACHE_HOME}/zsh_cache

# Ignore current directory when use `cd ../<TAB>`
zstyle ':completion:*:cd:*' ignore-parents parent pwd

# Ignore intermediate files in `cd` command
zstyle ':completion:*:*files' ignored-patterns '*?.o' '*?~' '*\#'

zstyle ':zle:*' word-chars '*?_.~-=&!#$%^(){}[]<>./;:@,| '
zstyle ':zle:*' word-style unspecified
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' keep-prefix
zstyle ':completion:*:sudo:*' command-path /usr/bin
