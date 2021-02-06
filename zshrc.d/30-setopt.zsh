setopt auto_cd
setopt auto_pushd
setopt pushd_silent

# zsh history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_no_store
HISTFILE=$HOME/.zsh-history
HISTSIZE=100000  # save in RAM
SAVEHIST=1000000 # save in file

