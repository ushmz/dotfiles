##########################################################
# alias to shorten
##########################################################
alias jn='jupyter notebook'

##########################################################
# Shorten my script
##########################################################
alias 'mux.sh'='~/.scripts/mux.sh'
alias bib='python ~/.scripts/biblio_poll.py'
alias ssh='~/.scripts/ssh_change_profile.sh'

##########################################################
# Alternative aliases
##########################################################
alias cat='bat'
alias find='fd'
alias ls="exa -gh --time-style=long-iso"
alias ll="ls -lF --group-directories-first --icons"
alias la="ls -alF --group-directories-first --icons"
alias gitls="exa -gl --git --git-ignore --time-style=long-iso --group-directories-first --icons"
alias src="cd `ghq root`"
# alias silicon="silicon --theme OneHalfDark"

# clean cache
alias 'pipcc'='rm -rf ~/Library/Caches/pip'
alias 'mavencc'='rm -rf ~/.m2/repository'

##########################################################
# peco aliases
##########################################################
# Switch branch with peco
alias -g edas='git checkout `git branch | peco --prompt "GIT BRANCH>" | head -n 1 | sed -e "s/^\*\s*//g"`'

# Delete branch with peco
alias -g prune='git branch -d `git branch | peco --prompt "GIT BRANCH>" | head -n 1 | sed -e "s/^\*\s*//g"`'
