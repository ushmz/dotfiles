# Start tmux session
if [[ $SHLVL = 1 && $TERM = "alacritty" ]]; then
  tmux
fi

# To make if statement simple
has() { type "${1:?too few arguments}" &>/dev/null }

# starship (cross-shell prompt)
if has "starship"
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
if has "direnv"; then
    eval "$(direnv hook zsh)"
fi

# asdf (Language version manager)
if has "asdf"; then
    . $(brew --prefix asdf)/asdf.sh
    # asdf jenv
    . ~/.asdf/plugins/java/set-java-home.zsh
fi
