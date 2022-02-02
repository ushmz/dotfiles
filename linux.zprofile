#!/bin/zsh

for i in $(command ls -I '*.darwin.zsh' `pwd`/zprofile.d/ | sort)
do
  source $i
done
