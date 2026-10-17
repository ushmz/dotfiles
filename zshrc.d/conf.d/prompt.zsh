has starship || return

setopt prompt_subst

cache_init starship init zsh --print-full-init && source ${REPLY}
