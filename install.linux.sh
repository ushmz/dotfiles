if ! git; then
    sudo apt install git
fi

mkdir -p $HOME/.cache
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.cache
