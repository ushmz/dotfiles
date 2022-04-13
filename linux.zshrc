#!/bin/zsh

for i in $(command ls -d $HOME/dotfiles/zshrc.d/*.zsh | grep -v '.*\.darwin\.zsh' | sort)
do
  source $i
done
