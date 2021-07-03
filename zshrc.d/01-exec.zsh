##########################################################
# Start tmux session
##########################################################
if [ $SHLVL = 1 ]; then
  tmux
fi

# starship (cross-shell prompt)
eval "$(starship init zsh)"

# python virtual env
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

# java virtual env
if command -v jenv 1>/dev/null 2>&1; then
  eval "$(jenv init -)"
fi

# Elixer virtual env
if command -v exenv 1>/dev/null 2>&1; then
  eval "$(exenv init -)"
fi

# direnv
export EDITOR=vi
eval "$(direnv hook zsh)"
