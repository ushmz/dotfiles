#!/bin/zsh

for i in $(command ls `pwd`/zprofile.d/*.zsh | sort)
do
  source $i
done
