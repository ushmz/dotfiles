#!/bin/zsh

for i in $(command ls $HOME/dotfiles/zprofile.d/ | grep -v '.*\.darwin\.zsh' sort)
do
  source $i
done
