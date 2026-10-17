# Set here (not in zprofile) because /etc/zshrc overwrites them
HISTFILE=${XDG_STATE_HOME}/.zsh_history
HISTSIZE=100000  # save in RAM
SAVEHIST=1000000 # save in file

setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_no_store

# Do not record trivial commands
function _history_ignore_trivial() {
    local line=${1%%$'\n'}
    [[ ! ${line} =~ "^(cd|jj?|lazygit|la|ll|ls|rm|rmdir)($| )" ]]
}
add-zsh-hook zshaddhistory _history_ignore_trivial

if has atuin; then
    cache_init atuin init zsh && source ${REPLY}
fi
