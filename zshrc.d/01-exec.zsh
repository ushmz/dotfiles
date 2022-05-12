# Start tmux session
if [[  $SHLVL = 1 && $TERM = "alacritty"  ]]; then
  tmux
fi

# starship (cross-shell prompt)
if command -v starship > /dev/null
then
    eval "$(starship init zsh)"
else
    setopt prompt_subst
    precmd_refresh_prompt() {
        export PS1=$'\n'"%F{green}%n%f%F{blue}@%f%F{green}%m%f:%~"$'\n'`if [[ $? -eq 0 ]]; then echo %F{white}\>\>\> %f; else echo %F{red}\>\>\> %f; fi`
    }
    autoload -Uz add-zsh-hook
    add-zsh-hook precmd precmd_refresh_prompt
fi

# direnv
if command -v direnv > /dev/null; then
    eval "$(direnv hook zsh)"
fi
