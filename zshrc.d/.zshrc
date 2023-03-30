for i in $(/bin/ls $HOME/dotfiles/zshrc.d/*.zsh | sort)
do
  source $i
done
