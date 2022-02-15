#!/bin/zsh

for i in $(command ls $HOME/dotfiles/zshrc.d/*.zsh | sort)
do
  source $i
done
