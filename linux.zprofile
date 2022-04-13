#!/bin/zsh

for i in $(command ls -d $HOME/dotfiles/zprofile.d/* | grep -v '.*\.darwin\.zsh' | sort)
do
  source $i
done

export PATH="/usr/local/pyenv/shims:/usr/local/pyenv/bin:/usr/local/bin:$PATH"
