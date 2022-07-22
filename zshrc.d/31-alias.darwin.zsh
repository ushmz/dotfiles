##########################################################
# OS specific aliases
##########################################################
alias stat='stat -x'

alias delds='/usr/bin/find . -name ".DS_Store" | xargs rm'
alias rmdsstore="/usr/bin/find . -name '*.DS_Store' -type f -ls -delete"
alias slpon='sudo pmset -a disablesleep 0'
alias slpoff='sudo pmset -a disablesleep 1'

alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
alias brave="/Applications/Brave\ Browser.app/Contents/MacOS/Brave\ Browser"

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
