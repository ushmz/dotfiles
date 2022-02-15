#!/bin/zsh

for i in $(command ls $HOME/dotfiles/zprofile.d/*.zsh | sort)
do
  source $i
done
