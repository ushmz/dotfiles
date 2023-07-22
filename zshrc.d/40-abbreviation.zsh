local function map() {
    if type abbr &>/dev/null; then
        abbr -g -S -q --force "$@" &>/dev/null
    else
        alias "$@"
    fi
}

# Replace BSD tools to GNU tools
if [ "$(uname)" = "Darwin" ]; then
    (( ${+commands[gdate]} )) && map date='gdate'
    (( ${+commands[gls]} )) && map ls='gls'
    (( ${+commands[gls]} )) && map ll='gls -lhF --group-directories-first'
    (( ${+commands[gls]} )) && map la='gls -alhF --group-directories-first'
    (( ${+commands[gmkdir]} )) && map mkdir='gmkdir'
    (( ${+commands[gcp]} )) && map cp='gcp'
    (( ${+commands[gmv]} )) && map mv='gmv'
    (( ${+commands[grm]} )) && map rm='grm'
    (( ${+commands[gdu]} )) && map du='gdu'
    (( ${+commands[ghead]} )) && map head='ghead'
    (( ${+commands[gtail]} )) && map tail='gtail'
    (( ${+commands[gsed]} )) && map sed='gsed'
    (( ${+commands[ggrep]} )) && map grep='ggrep'
    (( ${+commands[gfind]} )) && map find='gfind'
    (( ${+commands[gdirname]} )) && map dirname='gdirname'
    (( ${+commands[gxargs]} )) && map xargs='gxargs'
fi

# Force to check if the following arguments is abbr -g -S -q or not
# and avoid resetting environment variables
map sudo='sudo -E '

map c='clear'
map so='source'
map ll='ls -lhF'
map la='ls -alhF'
map ...='cd ../../'
map ....='cd ../../../'

map rm='rm -i'
map mv='mv -i'
map cp='cp -i'
map wget='wget --hsts-file="${XDG_CACHE_HOME}/wget-hsts"'

if type exa &>/dev/null; then
    map ls='exa -x --icons --group-directories-first'
    map ll='exa -ghlxF --icons --group-directories-first --time-style=long-iso'
    map la='exa -aghlxF --icons --group-directories-first --time-style=long-iso'
    map gitls='exa -aghlxF --icons --group-directories-first --time-style=long-iso --git --git-ignore'
fi

if type nvim &>/dev/null; then
    map vi='nvim'
    map vim='nvim'
fi

if type gh &>/dev/null; then
    map gv='gh repo view --web'
    map gcheck='gh pr checkout'
fi

# You can switch theme depending on MacOS dark mode
# if type bat &>/dev/null; then
#     abbr -g -S -q cat="bat --theme=\$(defaults read -globalDomain AppleInterfaceStyle &> /dev/null && echo ansi || echo GitHub)"
# fi

map zshenv='vi ~/.zshenv'
map zprofile='vi ~/dotfiles/zprofile.d'
map zshrc='vi ~/dotfiles/zshrc.d'
map soenv='source ~/.zshenv'
map sorc='source ~/.zshrc'
map soprof='source ~/.zprofile'
map dot='cd ~/dotfiles'
