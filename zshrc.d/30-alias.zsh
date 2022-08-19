##########################################################
# alias to shorten
##########################################################
# Force to check if the following arguments is alias or not
# and avoid resetting environment variables
alias sudo='sudo -E '

alias c='clear '
alias so='source '
alias ll="ls -lF --group-directories-first"
alias la="ls -alF --group-directories-first"
alias ...="cd ../../"
alias ....="cd ../../../"

alias zshenv='vi ~/.zshenv'
alias zprof='vi ~/dotfiles/zprofile.d'
alias zshrc='vi ~/dotfiles/zshrc.d'
alias soenv='source ~/.zshenv'
alias sorc='source ~/.zshrc'
alias soprof='source ~/.zprofile'
alias dot='cd ~/dotfiles'

##########################################################
# Shorten my script
##########################################################
alias 'mux.sh'='~/.scripts/mux.sh'
alias bib='python ~/.scripts/biblio_poll.py'
# alias ssh='~/.scripts/ssh_change_profile.sh'

##########################################################
# Alternative aliases
##########################################################
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'

alias free='free -h --giga'

# clean cache
alias 'pipcc'='rm -rf ~/Library/Caches/pip'
alias 'mavencc'='rm -rf ~/.m2/repository'

if has "nvim"; then
    alias vi='nvim'
    alias vim='nvim'
fi

if has "neovide"; then
    alias neovide='neovide --multigrid -- -u ~/dotfiles/.config/nvim/init.neovide.vim'
fi

if has "ranger"; then
    alias ranger='TERM=xterm-256color ranger'
    alias rg='TERM=xterm-256color ranger'
fi

if has "tig"; then
    alias tig='TERM=xterm-256color tig'
fi

if has "peco"; then
    # Switch branch with peco
    alias edas='git checkout `git branch | peco --prompt "GIT BRANCH>" | head -n 1 | sed -e "s/^\*\s*//g"`'

    # Delete branch with peco
    alias prune='git branch -d `git branch | peco --prompt "GIT BRANCH>" | head -n 1 | sed -e "s/^\*\s*//g"`'
fi

if has "exa"; then
    alias ls="exa -gh --time-style=long-iso"
    alias ll="ls -lF --group-directories-first --icons"
    alias la="ll -a"
    alias gitls="ll --git --git-ignore"
fi

if has "gh"; then
    alias gv="gh repo view --web"
    alias gcheck="gh pr checkout "
fi
