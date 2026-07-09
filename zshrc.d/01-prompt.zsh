bindkey -e

setopt prompt_subst
autoload -Uz add-zsh-hook

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^o' edit-command-line

eval "$(starship init zsh)"
