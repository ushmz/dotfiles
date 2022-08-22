#!/bin/sh
set -eu

mkdir -p ${HOME}/.config
export XDG_CONFIG_HOME=${HOME}/.config

mkdir -p ${HOME}/.local/state
export XDG_STATE_HOME=${HOME}/.local/state

mkdir -p ${HOME}/.local/share
export XDG_DATA_HOME=${HOME}/.local/share

mkdir -p ${HOME}/.cache
export XDG_CACHE_HOME=${HOME}/.cache

# Make directory for cdr
mkdir -p ${XDG_CACHE_HOME}/shell

# Remove `~/.zprofile` if exists, and write my `.zprofile`.
if [ -L ${HOME}/.zprofile ]; then
    unlink ${HOME}/.zprofile
fi
ln -sf `pwd`/.zprofile ${HOME}/.zprofile

# Remove `~/.zshrc` if exists, and write my `.zshrc`.
if [ -L ${HOME}/.zshrc ]; then
    unlink ${HOME}/.zshrc
fi
ln -sf `pwd`/.zshrc ${HOME}/.zshrc


# vscode
ln -sf `pwd`/vscode/settings.json "${HOME}/Library/Application Support/Code/User/settings.json"
ln -sf `pwd`/vscode/keybindings.json "${HOME}/Library/Application Support/Code/User/keybindings.json"


# .tigrc
mkdir -p ${XDG_DATA_HOME}/tig
# mkdir -p ${XDG_CONFIG_HOME}/tig/config
# ln -sf `pwd`/.config/tig/config/.tigrc ${XDG_CONFIG_HOME}/tig/config/.tigrc
ln -sf `pwd`/.config/tig/config/.tigrc ${XDG_CONFIG_HOME}/tig/config


# alacritty config file
mkdir -p ${XDG_CONFIG_HOME}/alacritty/
ln -sf `pwd`/.config/alacritty/alacritty.yml ${XDG_CONFIG_HOME}/alacritty/alacritty.yml


# .tmux.conf
mkdir -p ${XDG_CONFIG_HOME}/tmux/
ln -sf `pwd`/.config/tmux/.tmux.conf ${XDG_CONFIG_HOME}/tmux/tmux.conf


# starship.toml
ln -sf `pwd`/.config/starship.toml ${XDG_CONFIG_HOME}/starship.toml


mkdir -p ${XDG_CONFIG_HOME}/git
ln -sf `pwd`/.config/git/config ${XDG_CONFIG_HOME}/git/config
# .gitmessage
ln -sf `pwd`/.config/git/message ${XDG_CONFIG_HOME}/git/message
# .gitignore_global
ln -sf `pwd`/.config/git/ignore ${XDG_CONFIG_HOME}/git/ignore

# gh config
ln -sf `pwd`/.config/gh/config.yml ${XDG_CONFIG_HOME}/gh/config.yml


# ranger config files
ln -sf `pwd`/.config/ranger/* ${XDG_CONFIG_HOME}/ranger/


# nvim
mkdir -p ${XDG_CONFIG_HOME}/nvim/
ln -sf `pwd`/.config/nvim/init.lua ${XDG_CONFIG_HOME}/nvim/init.lua
ln -sf `pwd`/.config/nvim/lua ${XDG_CONFIG_HOME}/nvim/lua

# dein plugin files
ln -sf `pwd`/.config/nvim/dein.toml ${XDG_CONFIG_HOME}/nvim/dein.toml
ln -sf `pwd`/.config/nvim/dein_lazy.toml ${XDG_CONFIG_HOME}/nvim/dein_lazy.toml

# vim skeleton files
mkdir -p ${XDG_CONFIG_HOME}/nvim/templates
ln -sf `pwd`/.config/nvim/templates/skeleton.sh ${XDG_CONFIG_HOME}/nvim/templates/skeleton.sh

# Utility scripts
for script in $(ls -I '*.md' `pwd`/.scripts/* | xargs -n 1 basename); do
    ln -sf `pwd`/.scripts/$script ${HOME}/.scripts/${script}
done

# Stop dirtying home directory
echo hsts-file \= "${XDG_CACHE_HOME}"/wget-hsts > "${XDG_CONFIG_HOME}/wgetrc"

mkdir -p "${XDG_CONFIG_HOME}/python"
touch "${XDG_CONFIG_HOME}/python/pythonrc"
echo -n "import readline\nreadline.set_auto_history(False)" > "${XDG_CONFIG_HOME}/python/pythonrc"
