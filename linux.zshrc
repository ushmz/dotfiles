#!/bin/zsh

for i in $(command ls $HOME/dotfiles/zshrc.d/ | grep -v '.*\.darwin\.zsh' | sort)
do
  source $i
done
