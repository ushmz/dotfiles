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
alias jn='jupyter notebook'

##########################################################
# Shorten my script
##########################################################
alias 'mux.sh'='~/.scripts/mux.sh'
alias bib='python ~/.scripts/biblio_poll.py'
# alias ssh='~/.scripts/ssh_change_profile.sh'

##########################################################
# Alternative aliases
##########################################################
alias ls="exa -gh --time-style=long-iso"
alias ll="ls -lF --group-directories-first --icons"
alias la="ll -a"
alias gitls="ll --git --git-ignore"
alias src="cd `ghq root`"
alias ldoc="lazydocker"
# alias silicon="silicon --theme OneHalfDark"

# clean cache
alias 'pipcc'='rm -rf ~/Library/Caches/pip'
alias 'mavencc'='rm -rf ~/.m2/repository'

alias vi='nvim'
alias vim='nvim'
alias neovide='neovide --multigrid -- -u ~/dotfiles/.config/nvim/init.neovide.vim'

##########################################################
# peco aliases
##########################################################
# Switch branch with peco
alias -g edas='git checkout `git branch | peco --prompt "GIT BRANCH>" | head -n 1 | sed -e "s/^\*\s*//g"`'

# Delete branch with peco
alias -g prune='git branch -d `git branch | peco --prompt "GIT BRANCH>" | head -n 1 | sed -e "s/^\*\s*//g"`'
