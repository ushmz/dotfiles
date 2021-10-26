##########################################################
# alias to shorten
##########################################################
alias c='clear'
alias so='source'

alias ll="ls -lF --group-directories-first"
alias la="ls -alF --group-directories-first"

alias '...'='cd ../../'
alias '....'='cd ../../../'
alias delds='/usr/bin/find . -name ".DS_Store" | xargs rm'
alias slpon='sudo pmset -a disablesleep 0'
alias slpoff='sudo pmset -a disablesleep 1'

alias zshenv='vi ~/.zshenv'
alias zprof='vi ~/dotfiles/zprofile.d'
alias zshrc='vi ~/dotfiles/zshrc.d'
alias soenv='source ~/.zshenv'
alias sorc='source ~/.zshrc'
alias soprof='source ~/.zprofile'

##########################################################
# Alternative aliases
##########################################################
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
alias stat='stat -x'
alias vi='nvim'
alias vim='nvim'
