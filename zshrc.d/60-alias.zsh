
##########################################################
# alias to shorten
##########################################################
alias c='clear'
alias so='source'
alias jn='/Users/yusuk/Library/Python/3.8/bin/jupyter notebook'
alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
alias brave="/Applications/Brave\ Browser.app/Contents/MacOS/Brave\ Browser"

alias '...'='cd ../../'
alias '....'='cd ../../../'
alias delds='find . -name ".DS_Store" | xargs rm'
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
alias 'mux.sh'='~/.scripts/mux.sh'
alias 'bib'='python ~/.scripts/biblio_poll.py'

##########################################################
# Alternative aliases
##########################################################
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
alias stat='stat -x'
alias cat='bat'
alias find='fd'
alias ls="exa -gh --time-style=long-iso"
alias ll="ls -lF"
alias la="ls -alF"
alias gitls="exa -gl --git --git-ignore --time-style=long-iso --group-directories-first"
alias ssh='~/.scripts/ssh_change_profile.sh'
alias vi='nvim'
alias vim='nvim'
# alias silicon="silicon --theme OneHalfDark"

# Make my cv with yaml file
alias -g makecv='/Users/yusuk/src/github.com/kaityo256/yaml_cv/make_cv.rb'

# clean cache
alias 'pipcc'='rm -rf ~/Library/Caches/pip'
alias 'mavencc'='rm -rf ~/.m2/repository'

##########################################################
# peco aliases
##########################################################
# Switch branch with peco
alias -g branches='git checkout `git branch | peco --prompt "GIT BRANCH>" | head -n 1 | sed -e "s/^\*\s*//g"`'

# Delete branch with peco
alias -g delbranch='git branch -d `git branch | peco --prompt "GIT BRANCH>" | head -n 1 | sed -e "s/^\*\s*//g"`'
