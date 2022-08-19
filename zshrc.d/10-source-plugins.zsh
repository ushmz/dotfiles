# zsh highlighting & auto suggestion plugins

# For darwin, install following packages via brew
if [ -d /usr/local/share/zsh-syntax-highlighting ]; then
    source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

if [ -d /usr/local/share/zsh-autosuggestions ]; then
    source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

if [ -d /usr/local/share/zsh-completions/ ]; then
  fpath=(/usr/local/share/zsh-completions/ $fpath)
fi


# For linux, install following packages manually with git
if [ -d $HOME/.cache/zsh-syntax-highlighting/ ]; then
    source $HOME/.cache/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

if [ -d $HOME/.cache/zsh-autosuggestions ]; then
    source $HOME/.cache/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# zsh completions for linux
if [ -d $HOME/.cache/zsh-completions ]; then
  FPATH=$HOME/.cache/zsh-completions/src:$FPATH
fi


ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets cursor)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=245'
