# Start tmux session
if [[  $SHLVL = 1 && $TERM = "alacritty"  ]]; then
  tmux
fi

has() { type "${1:?too few arguments}" &>/dev/null }

# starship (cross-shell prompt)
if has "starship" > /dev/null
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
if has "direnv" > /dev/null; then
    eval "$(direnv hook zsh)"
fi
