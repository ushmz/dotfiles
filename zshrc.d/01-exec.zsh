
##########################################################
# Start tmux session
##########################################################
# if [ $SHLVL = 1 ]; then
#   tmux
# fi
##########################################################
# starship (cross-shell prompt)
##########################################################
eval "$(starship init zsh)"

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

if command -v jenv 1>/dev/null 2>&1; then
  eval "$(jenv init -)"
fi

if command -v exenv 1>/dev/null 2>&1; then
  eval "$(exenv init -)"
fi
