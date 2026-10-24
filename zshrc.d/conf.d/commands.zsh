# Replacements and default options for basic commands
# cspell:disable

# Replace BSD tools to GNU tools
if [[ ${OSTYPE} == darwin* ]]; then
    has gdate && map date='gdate'
    has gmkdir && map mkdir='gmkdir'
    has gdu && map du='gdu'
    has ghead && map head='ghead'
    has gtail && map tail='gtail'
    has gsed && map sed='gsed'
    has ggrep && map grep='ggrep'
    has gfind && map find='gfind'
    has gdirname && map dirname='gdirname'
    has gxargs && map xargs='gxargs'
    has gawk && map awk='gawk'
    has gtar && map tar='gtar'
    has gmake && map make='gmake'
fi

# ls
if has gdircolors; then
    cache_init gdircolors -b && source ${REPLY}
fi
if [[ -n ${LS_COLORS} ]]; then
    zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
fi

if has eza; then
    map ls='eza -x --icons --group-directories-first'
    map ll='eza -ghlxF --icons --group-directories-first --time-style=long-iso'
    map la='eza -aghlxF --icons --group-directories-first --time-style=long-iso'
    map gitls='eza -aghlxF --icons --group-directories-first --time-style=long-iso --git --git-ignore'
elif has gls; then
    map ls='gls'
    map ll='gls -lhF --group-directories-first'
    map la='gls -alhF --group-directories-first'
else
    map ll='ls -lhF'
    map la='ls -alhF'
fi

map rm='rm -i'
map mv='mv -i'
map cp='cp -i'
map wget='wget --hsts-file="${XDG_CACHE_HOME}/wget-hsts"'

if has nvim; then
    map vi='nvim'
    map vim='nvim'
fi
