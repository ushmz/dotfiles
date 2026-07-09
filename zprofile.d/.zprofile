for i in $(/bin/ls $HOME/dotfiles/zprofile.d/*.zsh | sort); do
	# shellcheck source=/dev/null
	source $i
done

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init.zsh 2>/dev/null || :
