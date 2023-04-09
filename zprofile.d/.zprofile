for i in $(/bin/ls $HOME/dotfiles/zprofile.d/*.zsh | sort); do
	# shellcheck source=/dev/null
	source $i
done
