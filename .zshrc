#!/bin/zsh

for i in $(command ls `pwd`/zshrc.d/*.zsh | sort)
do
  source $i
done
