
##########################################################
# alias to shorten
##########################################################
alias c='clear'
alias so='source'
alias jn='/Users/yusuk/Library/Python/3.8/bin/jupyter notebook'
alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
alias brave="/Applications/Brave\ Browser.app/Contents/MacOS/Brave\ Browser"
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'

alias '...'='cd ../../'
alias '....'='cd ../../../'
alias delds='find . -name ".DS_Store" | xargs rm'
alias repo='cd /Users/yusuk/rabhare6it'
alias slpon='sudo pmset -a disablesleep 0'
alias slpoff='sudo pmset -a disablesleep 1'

alias zshenv='vi ~/.zshenv'
alias zprof='vi ~/.zprofile'
alias zshrc='vi ~/.zshrc'
alias soenv='source ~/.zshenv'
alias sorc='source ~/.zshrc'
alias soprof='source ~/.zprofile'

##########################################################
# Shorten my script
##########################################################
alias tm='~/bin/tm.sh'

##########################################################
# Alternative aliases
##########################################################
alias stat='stat -x'
alias cat='bat'
alias find='fd'
alias ls="exa -gh --time-style=long-iso"
alias ll="ls -lF"
alias la="ls -alF"
alias gitls="exa -gl --git --git-ignore --time-style=long-iso --group-directories-first"
alias ssh='~/bin/ssh_change_profile.sh'

##########################################################
# peco aliases
##########################################################
# Switch branch with peco
alias -g branches='git checkout `git branch | peco --prompt "GIT BRANCH>" | head -n 1 | sed -e "s/^\*\s*//g"`'

# Delete branch with peco
alias -g delbranch='git branch -d `git branch | peco --prompt "GIT BRANCH>" | head -n 1 | sed -e "s/^\*\s*//g"`'