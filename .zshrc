# in ~/.zshenv, executed `unsetopt GLOBAL_RCS` and ignored /etc/zshrc
# [ -r /etc/zshrc ] && . /etc/zshrc

##########################################################
# zsh settings 
##########################################################
# bindkey -v
setopt auto_cd
setopt auto_pushd
setopt pushd_silent

# zsh history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_no_store
HISTFILE=$HOME/.zsh-history
HISTSIZE=100000  # save in RAM
SAVEHIST=1000000 # save in file

# Enable `cdr`
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

# save dirstack to ~/.cache/shell
mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}/shell"
touch "${XDG_CACHE_HOME:-$HOME/.cache}/shell/$HOST.dirstack"
my_save_dirstack () {
    dirstack=(${(@u)$(<"${XDG_CACHE_HOME:-$HOME/.cache}/shell/$HOST.dirstack")})
    dirs -lp >! "${XDG_CACHE_HOME:-$HOME/.cache}/shell/$HOST.dirstack"
}
chpwd_functions+=my_save_dirstack
my_save_dirstack

# `cdr` settings
zstyle ':completion:*' recent-dirs-insert both
zstyle ':chpwd:*' recent-dirs-max 500
zstyle ':chpwd:*' recent-dirs-default true
zstyle ':chpwd:*' recent-dirs-file "$HOME/.cache/shell/chpwd-recent-dirs"
zstyle ':chpwd:*' recent-dirs-pushd true

# aliases
alias c='clear'
alias so='source'
alias '...'='cd ../../'
alias '....'='cd ../../../'
alias jn='/Users/yusuk/Library/Python/3.8/bin/jupyter notebook'
alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
alias stat='stat -x'
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
alias cat='bat'
alias find='fd'
alias ls="exa -gh --time-style=long-iso"
alias ll="ls -lF"
alias la="ls -alF"
alias gitls="exa -gl --git --git-ignore --time-style=long-iso --group-directories-first"

alias tm='~/bin/tm.sh'
alias ssh='~/bin/ssh_change_profile.sh'
alias zshrc='vi ~/.zshrc'
alias zshenv='vi ~/.zshenv'
alias sorc='source ~/.zshrc'
alias soenv='source ~/.zshenv'

alias repo='cd /Users/yusuk/rabhare6it'
alias delds='find . -name ".DS_Store" | xargs rm'
alias slpon='sudo pmset -a disablesleep 0'
alias slpoff='sudo pmset -a disablesleep 1'

# Original comands
export PATH="/Users/yusuk/bin:$PATH"
source /Users/yusuk/bin/cmdnotif

# starship (cross-shell prompt)
eval "$(starship init zsh)"

# exa Settings
export LS_COLORS="di=01;32;"
export EXA_COLORS="da=36"

# Use same color on auto-complete of zsh
if [ -n "$LS_COLORS" ]; then
    zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
fi

# zsh auto completions
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
  autoload -Uz compinit && compinit
fi
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

##########################################################
# Programing Languages
##########################################################

# php
export PATH="/usr/local/opt/php@7.2/bin:$PATH"
export PATH="/usr/local/opt/php@7.2/sbin:$PATH"
# /usr/local/Cellar/php/7.4.4/bin

# Go lang(Set GOPATH)
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN

##########################################################
# Virtual Environments
##########################################################

# jenv
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH

# exenv
export PATH="$HOME/.exenv/bin:$PATH"
eval "$(exenv init -)"

##########################################################
# Development Tools
##########################################################

# Android SDK
export ANDROID_SDK_HOME=/Users/yusuk/Library/Android/sdk
export ANDROID_HOME=/Users/yusuk/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

# react-native
export PATH="/usr/local/share/npm/bin:$PATH"
export PATH=${PATH}:${HOME}/node_modules/.bin
if [ -d ${HOME}/node_modules/.bin ]; then
    export PATH=${PATH}:${HOME}/node_modules/.bin
fi

# poetry
export PATH="$HOME/.poetry/bin:$PATH"

# postgres
export PGDATA="/usr/local/var/postgres"

##########################################################
# Alcaritty auto complation setting
##########################################################
fpath+=${ZDOTDIR:-~}/.zsh_functions

##########################################################
# typo hook
##########################################################
function command_not_found_handler(){
    if [ -e ~/bin/typo.sh ]; then
        ~/bin/typo.sh
    else
        echo "Command $0 not found."
    fi
    return 127
}

##########################################################
# peco functions
##########################################################
# Search command history
function peco_select_history() {
  BUFFER=$(\history -n -r 1 | peco --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle reset-prompt
}
zle -N peco_select_history
bindkey '^r' peco_select_history

## Search s distination from cdr list
function peco_get_destination_from_cdr() {
  cdr -l | \
  sed -e 's/^[[:digit:]]*[[:blank:]]*//' | \
  peco --query "$LBUFFER"
}

# Search directory from history
function peco_cdr() {
  local destination="$(peco_get_destination_from_cdr)"
  if [ -n "$destination" ]; then
    BUFFER="cd $destination"
    zle accept-line
  else
    zle reset-prompt
  fi
}
zle -N peco_cdr
bindkey '^u' peco_cdr

# Switch branch with peco
alias -g branches='git checkout `git branch | peco --prompt "GIT BRANCH>" | head -n 1 | sed -e "s/^\*\s*//g"`'

# Delete branch with peco
alias -g delbranch='git branch -d `git branch | peco --prompt "GIT BRANCH>" | head -n 1 | sed -e "s/^\*\s*//g"`'

# Search tmux session
## This cause freezing peco window...
# function peco_tmux_sessions() {
#  local res=$(tmux list-sessions | peco --query "$LBUFFER" | awk -F':' '{print $1}')
#   if [ -n "$res" ]; then
#     BUFFER="tmux attach -t $res"
#     CURSOR=$#BUFFER
#     zle clear-screen
#   else
#     zle reset-prompt
#   fi
# }
# zle -N peco_tmux_sessions
# bindkey '^s' peco_tmux_sessions

function peco_ssh_host() {
  local res=$(grep "Host " ~/.ssh/config | grep -v '*' | cut -b 6- | peco)
  if [ -n "$res" ]; then
    BUFFER="ssh $res"
    CURSOR=$#BUFFER
    zle clear-screen
  else
    zle reset-prompt
  fi
}
zle -N peco_ssh_host
bindkey '^h' peco_ssh_host

