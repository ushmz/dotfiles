if ! git; then
	sudo apt install git
fi

mkdir -p $HOME/.cache

git clone https://github.com/hlissner/zsh-autopair ${XDG_CACHE_HOME}/zsh-autopair
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${XDG_CACHE_HOME}/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${XDG_CACHE_HOME}/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-completions.git ${XDG_CACHE_HOME}/zsh-completions
