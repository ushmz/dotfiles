#! /bin/sh

# zsh plugins
mkdir -p ${HOME}/.cache
git clone https://github.com/hlissner/zsh-autopair ${HOME}/.cache/zsh-autopair
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${HOME}/.cache/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${HOME}/.cache/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-completions.git ${HOME}/.cache/zsh-completions

if [[ ${OSTYPE} == *darwin* ]]; then
	# Install brew
	if [ ! type brew &>/dev/null ]; then
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
	fi

	brew update
	brew cleanup
    brew bundle
	brew cleanup
fi
