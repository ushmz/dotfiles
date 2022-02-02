#!/bin/zsh

for i in $(command ls -I '*.darwin.zsh' `pwd`/zshrc.d/ | sort)
do
  source $i
done
