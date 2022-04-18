# zsh highlighting & auto completions

# For darwin
if [-d /usr/local/share/zsh-syntax-highlighting/]; then
    source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# For linux
if [-d $HOME/.cache/zsh-syntax-highlighting/]; then
    source $HOME/.cache/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    source $HOME/.cache/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets cursor)
