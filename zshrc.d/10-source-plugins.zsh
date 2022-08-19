# zsh highlighting & auto suggestion plugins

# For darwin, install following packages via brew
if [ -d $(brew --prefix zsh-syntax-highlighting) ]; then
    source $(brew --prefix zsh-syntax-highlighting)/zsh-syntax-highlighting.zsh
fi

if [ -d $(brew --prefix zsh-autosuggestions) ]; then
    source $(brew --prefix zsh-autosuggestions)/zsh-autosuggestions.zsh
fi

if [ -d $(brew --prefix zsh-completions) ]; then
  fpath=($(brew --prefix zsh-completions)/src $fpath)
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
