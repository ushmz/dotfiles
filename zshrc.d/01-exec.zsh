# Start tmux session
if [[  $SHLVL = 1 && $TERM = "alacritty"  ]]; then
  tmux
fi

# starship (cross-shell prompt)
eval "$(starship init zsh)"

# direnv
export EDITOR=vi
eval "$(direnv hook zsh)"
