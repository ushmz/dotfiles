for i in $(/bin/ls $HOME/dotfiles/zprofile.d/*.zsh | sort)
do
  source $i
done
