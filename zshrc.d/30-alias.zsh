# Replace BSD tools to GNU tools
case "${OSTYPE}" in
    darwin*)
        (( ${+commands[gdate]} )) && alias date='gdate'
        (( ${+commands[gls]} )) && alias ls='gls'
        (( ${+commands[gmkdir]} )) && alias mkdir='gmkdir'
        (( ${+commands[gcp]} )) && alias cp='gcp'
        (( ${+commands[gmv]} )) && alias mv='gmv'
        (( ${+commands[grm]} )) && alias rm='grm'
        (( ${+commands[gdu]} )) && alias du='gdu'
        (( ${+commands[ghead]} )) && alias head='ghead'
        (( ${+commands[gtail]} )) && alias tail='gtail'
        (( ${+commands[gsed]} )) && alias sed='gsed'
        (( ${+commands[ggrep]} )) && alias grep='ggrep'
        (( ${+commands[gfind]} )) && alias find='gfind'
        (( ${+commands[gdirname]} )) && alias dirname='gdirname'
        (( ${+commands[gxargs]} )) && alias xargs='gxargs'
        ;;
esac

# Force to check if the following arguments is alias or not
# and avoid resetting environment variables
alias sudo='sudo -E '

alias c='clear '
alias so='source '
alias ll="ls -lhF --group-directories-first"
alias la="ls -alhF --group-directories-first"
alias ...="cd ../../"
alias ....="cd ../../../"

alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
alias free='free -h --giga'
alias wget='wget --hsts-file="${XDG_CACHE_HOME}/wget-hsts"'

if type exa &>/dev/null; then
    alias ls="exa -x --icons --group-directories-first"
    alias ll="ls -ghlF --time-style=long-iso"
    alias la="ll -a"
    alias gitls="ll --git --git-ignore"
fi

if type nvim &>/dev/null; then
    alias vi='nvim'
    alias vim='nvim'
fi

if type tig &>/dev/null; then
    alias tig='TERM=xterm-256color tig'
fi

if type gh &>/dev/null; then
    alias gv="gh repo view --web"
    alias gcheck="gh pr checkout "
fi

alias zshenv='vi ~/.zshenv'
alias zprofile='vi ~/dotfiles/zprofile.d'
alias zshrc='vi ~/dotfiles/zshrc.d'
alias soenv='source ~/.zshenv'
alias sorc='source ~/.zshrc'
alias soprof='source ~/.zprofile'
alias dot='cd ~/dotfiles'
alias 'mux.sh'='~/.scripts/mux.sh'
