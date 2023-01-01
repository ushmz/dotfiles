# Function definitions are in "42-functions_peco.zsh"
bindkey -e

# Ctrl-r to search command history
zle -N peco_select_history
bindkey '^r' peco_select_history

# Ctrl-u to search directory from history
zle -N peco_cdr
bindkey '^u' peco_cdr

# Ctrl-s to search tmux session
# zle -N peco_tmux_sessions
# bindkey '^s' peco_tmux_sessions

# Ctrl-s to search hostname from .ssh/config
zle -N peco_ssh_host
bindkey '^s' peco_ssh_host

# Ctrl-g to search local repository from ghq root
zle -N ghq_list
bindkey '^g' ghq_list

# Ctrl-e to open repository in `ghq root` with VSCode
# zle -N ghq_code
# bindkey '^e' ghq_code
