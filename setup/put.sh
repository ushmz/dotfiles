#!/bin/sh
set -eu

mkdir -p ${HOME}/.config
mkdir -p ${HOME}/.local/state
mkdir -p ${HOME}/.local/share
mkdir -p ${HOME}/.cache

# Make directory for cdr
mkdir -p ${HOME}/.cache/shell

# Remove `~/.zprofile` if exists, and write my `.zprofile`.
if [ -L ${HOME}/.zprofile ]; then
	unlink ${HOME}/.zprofile
fi
ln -sf $(pwd)/.zprofile ${HOME}/.zprofile

# Remove `~/.zshrc` if exists, and write my `.zshrc`.
if [ -L ${HOME}/.zshrc ]; then
	unlink ${HOME}/.zshrc
fi
ln -sf $(pwd)/.zshrc ${HOME}/.zshrc

# vscode
if [[ $OSTYPE == *darwin* ]]; then
	ln -sf $(pwd)/vscode/settings.json "${HOME}/Library/Application Support/Code/User/settings.json"
	ln -sf $(pwd)/vscode/keybindings.json "${HOME}/Library/Application Support/Code/User/keybindings.json"
fi

# .tigrc
mkdir -p ${HOME}/.config/tig/
ln -sf $(pwd)/.config/tig/config/.tigrc ${HOME}/.config/tig/config

# alacritty config file
mkdir -p ${HOME}/.config/alacritty/
ln -sf $(pwd)/.config/alacritty/alacritty.yml ${HOME}/.config/alacritty/alacritty.yml

# .tmux.conf
mkdir -p ${HOME}/.config/tmux/
ln -sf $(pwd)/.config/tmux/.tmux.conf ${HOME}/.config/tmux/tmux.conf
ln -sf $(pwd)/.config/tmux/battery ${HOME}/.config/tmux/battery
ln -sf $(pwd)/.config/tmux/ssid ${HOME}/.config/tmux/ssid

# starship.toml
ln -sf $(pwd)/.config/starship/starship.toml ${HOME}/.config/starship.toml

# git config
mkdir -p ${HOME}/.config/git/
ln -sf $(pwd)/.config/git/config ${HOME}/.config/git/config
ln -sf $(pwd)/.config/git/message ${HOME}/.config/git/message
ln -sf $(pwd)/.config/git/ignore ${HOME}/.config/git/ignore

# gh config
ln -sf $(pwd)/.config/gh/config.yml ${HOME}/.config/gh/config.yml

# ranger config files
ln -sf $(pwd)/.config/ranger/* ${HOME}/.config/ranger/

# nvim
mkdir -p ${HOME}/.config/nvim/
ln -sf $(pwd)/.config/nvim/init.lua ${HOME}/.config/nvim/init.lua
ln -sf $(pwd)/.config/nvim/lua ${HOME}/.config/nvim/lua

# vim skeleton files
mkdir -p ${HOME}/.config/nvim/templates
ln -sf $(pwd)/.config/nvim/templates/skeleton.sh ${HOME}/.config/nvim/templates/skeleton.sh

# Utility scripts
for script in $(ls -I '*.md' $(pwd)/.scripts/* | xargs -n 1 basename); do
	ln -sf $(pwd)/.scripts/$script ${HOME}/.scripts/${script}
done

# Stop dirtying home directory
echo hsts-file \= "${HOME}/.cache/wget-hsts" >"${HOME}/.config/wgetrc"

mkdir -p "${HOME}/.config/python"
touch "${HOME}/.config/python/pythonrc"
echo "import readline\nreadline.set_auto_history(False)\n" >"${HOME}/.config/python/pythonrc"
