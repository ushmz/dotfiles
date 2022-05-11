# zsh highlighting & auto suggestion plugins

# For darwin, install following packages via brew
if [ -d /usr/local/share/zsh-syntax-highlighting/ ]; then
    source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# For linux, install following packages manually with git
if [ -d $HOME/.cache/zsh-syntax-highlighting/ ]; then
    source $HOME/.cache/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    source $HOME/.cache/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets cursor)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=245'
