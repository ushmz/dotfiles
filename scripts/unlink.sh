#!/usr/bin/env sh
set -Cue

unlink "${HOME}/.zprofile"
unlink "${HOME}/.zshrc"

unlink "${HOME}/Library/Application Support/Code/User/settings.json"
unlink "${HOME}/Library/Application Support/Code/User/keybindings.json"
unlink "${XDG_DATA_HOME}/tig/.tigrc"
unlink "${XDG_CONFIG_HOME}/starship.toml"

rm -rf "${XDG_CONFIG_HOME}/alacritty"
rm -rf "${XDG_CONFIG_HOME}/tmux"
rm -rf "${XDG_CONFIG_HOME}/git/config"
rm -rf "${XDG_CONFIG_HOME}/gh/config"
rm -rf "${XDG_CONFIG_HOME}/ranger"
rm -rf "${XDG_CONFIG_HOME}/nvim"
rm -rf "${HOME}/.scripts"

rm "${XDG_CONFIG_HOME}/wgetrc"
rm -rf "${XDG_CONFIG_HOME}/python/pythonrc"
