if ! git; then
    sudo apt install git
fi

mkdir -p $HOME/.cache

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.cache/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.cache/zsh-autosuggestions
git clone git://github.com/zsh-users/zsh-completions.git $HOME/.cache/zsh-completions

chmod 755 $HOME/.cache/zsh-syntax-highlighting
chmod 755 $HOME/.cache/zsh-autosuggestions
chmod 755 $HOME/.cache/zsh-completions

fpath=($HOME/.cache/zsh-completions/src $fpath)
rm -f ~/.zcompdump
