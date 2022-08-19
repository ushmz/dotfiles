##########################################################
# OS specific aliases
##########################################################
alias stat='stat -x'

alias delds='/usr/bin/find . -name ".DS_Store" | xargs rm'
alias rmdsstore="/usr/bin/find . -name '*.DS_Store' -type f -ls -delete"
alias slpon='sudo pmset -a disablesleep 0'
alias slpoff='sudo pmset -a disablesleep 1'

alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"

##########################################################
# alias to shorten
##########################################################
if has "jupyter"; then
    alias jn='jupyter notebook'
fi

##########################################################
# Alternative aliases
##########################################################
alias src="cd `ghq root`"
alias ldoc="lazydocker"
# alias silicon="silicon --theme OneHalfDark"

alias term='echo -ne "\033]1337;SetProfile=$(peco ~/dotfiles/iTerm/.iterm_profiles)\a"'
