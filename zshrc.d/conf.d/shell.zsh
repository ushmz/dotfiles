# General shell behavior and shortcuts for editing this config

# For 8bit chars
setopt print_eight_bit

# Completing extended glob like `~`, `^` and more...
setopt extended_glob

# `.` insensitive matching
setopt globdots

autoload -Uz colors && colors

# Home/End/Delete keys.
# /etc/zshrc binds them too, but into the keymap active before `bindkey -e`.
zmodload zsh/terminfo
for cap widget in khome beginning-of-line kend end-of-line kdch1 delete-char; do
    [[ -n ${terminfo[$cap]} ]] && bindkey ${terminfo[$cap]} ${widget}
done
unset cap widget

# Edit the command line in $EDITOR
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^o' edit-command-line

# Force to check if the following arguments is abbr -g -S -q or not
# and avoid resetting environment variables
map sudo='sudo -E '

map c='clear'
map so='source'

map zshenv='vi ~/.zshenv'
map zprofile='vi ~/dotfiles/zprofile.d'
map zshrc='vi ~/dotfiles/zshrc.d'
map soenv='source ~/.zshenv'
map sorc='source ~/.zshrc'
map soprof='source ~/.zprofile'
map dot='cd ~/dotfiles'

# kiro shell integration
if [[ ${TERM_PROGRAM} == "kiro" ]] && has kiro; then
    source "$(kiro --locate-shell-integration-path zsh)"
fi
