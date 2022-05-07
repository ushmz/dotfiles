# Start tmux session
if [[  $SHLVL = 1 && $TERM = "alacritty"  ]]; then
  tmux
fi

# starship (cross-shell prompt)
if command -v starship > /dev/null; then
    eval "$(starship init zsh)"
fi

# direnv
if command -v direnv > /dev/null; then
    eval "$(direnv hook zsh)"
fi
