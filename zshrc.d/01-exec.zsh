# Start tmux session
if [[ $SHLVL = 1 && $TERM = "alacritty" ]]; then
  tmux
fi

# starship (cross-shell prompt)
if type starship &>/dev/null; then
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
if type direnv &>/dev/null; then
    eval "$(direnv hook zsh)"
fi

# asdf (Language version manager)
if type asdf &>/dev/null; then
    source $(brew --prefix asdf)/libexec/asdf.sh
fi
