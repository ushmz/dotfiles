export LS_COLORS="di=01;32;"
export EXA_COLORS="da=36"

# XDG_CONFIG_HOME
export XDG_CONFIG_HOME=$HOME/.config

# Original scripts
export PATH="$HOME/.scripts:$PATH"

# local packages
export PATH="$HOME/.local/bin:$PATH"

# zsh completions for darwin
if [ -e $(brew --prefix)/share/zsh-completions ]; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
fi

# zsh completions for linux
if [ -e $HOME/.cache/zsh-completions ]; then
  FPATH=$HOME/.cache/zsh-completions/src:$FPATH
fi
