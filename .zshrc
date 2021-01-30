# in ~/.zshenv, executed `unsetopt GLOBAL_RCS` and ignored /etc/zshrc
# [ -r /etc/zshrc ] && . /etc/zshrc

##########################################################
# Prompt settings 
##########################################################
# bindkey -v
setopt auto_cd
setopt hist_ignore_all_dups

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

