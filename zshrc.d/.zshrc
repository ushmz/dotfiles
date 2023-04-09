for i in $(/bin/ls $HOME/dotfiles/zshrc.d/*.zsh | sort); do
	# shellcheck source=/dev/null
	source $i
done
