##########################################################
# alias to shorten
##########################################################
alias c='clear'
alias so='source'
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

##########################################################
# Alternative aliases
##########################################################
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'

alias free='free -h --giga'

if has "nvim"; then
    alias vi='nvim'
    alias vim='nvim'
fi

if has "neovide"; then
    alias neovide='neovide --multigrid -- -u ~/dotfiles/.config/nvim/init.neovide.vim'
fi

if has "ranger"; then
    alias rg='ranger'
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
