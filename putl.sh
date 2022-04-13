#!/bin/sh
set -e

mkdir -p $HOME/.cache/shell
mkdir -p $HOME/.config
XDG_CONFIG_HOME=$HOME/.config

# ----------------------------------------------------------
# Remove `~/.zprofile` if exists, and write my `.zprofile`.
# ----------------------------------------------------------
if [ -L $HOME/.zprofile ]; then
    unlink $HOME/.zprofile
fi
ln -sf `pwd`/linux.zprofile $HOME/.zprofile

# ----------------------------------------------------
# Remove `~/.zshrc` if exists, and write my `.zshrc`.
# ----------------------------------------------------
if [ -L $HOME/.zshrc ]; then
    unlink $HOME/.zshrc
fi
ln -sf `pwd`/linux.zshrc $HOME/.zshrc

# ----------------------------------------------------
# Put symbolic links.
# ----------------------------------------------------

# .tmux.conf
ln -sf `pwd`/linux.tmux.conf $HOME/.tmux.conf

# starship.toml
ln -sf `pwd`/.config/starship.toml $XDG_CONFIG_HOME/starship.toml

# .gitmessage
ln -sf `pwd`/.gitmessage $HOME/.gitmessage

# .gitignore_global
ln -sf `pwd`/.gitignore_global $HOME/.gitignore_global
git config --local core.excludesfile $HOME/.gitignore_global	

# vim config file
mkdir -p $XDG_CONFIG_HOME/nvim/
ln -sf `pwd`/.vimrc $HOME/.vimrc
ln -sf `pwd`/.config/nvim/init.linux.vim $XDG_CONFIG_HOME/nvim/init.vim
ln -sf `pwd`/.config/nvim/init.d $XDG_CONFIG_HOME/nvim/init.d

# dein plugin files
ln -sf `pwd`/.config/nvim/dein.linux.toml $XDG_CONFIG_HOME/nvim/dein.toml
ln -sf `pwd`/.config/nvim/dein_lazy.toml $XDG_CONFIG_HOME/nvim/dein_lazy.toml

# coc setting file
ln -sf `pwd`/.config/nvim/coc-settings.linux.json $XDG_CONFIG_HOME/nvim/coc-settings.json

# vim skeleton files
mkdir -p $HOME/.vim/templates
mkdir -p $XDG_CONFIG_HOME/nvim/templates
ln -sf `pwd`/.config/nvim/templates/skeleton.sh $HOME/.vim/templates/skeleton.sh
ln -sf `pwd`/.config/nvim/templates/skeleton.sh $XDG_CONFIG_HOME/nvim/templates/skeleton.sh

# vim plugin `run command` files
mkdir -p "$XDG_CONFIG_HOME/nvim/plugins"
for rc in $(ls -I '*.md' `pwd`/.config/nvim/plugins/* | xargs -n 1 basename); do
    ln -sf `pwd`/.config/nvim/plugins/$rc $XDG_CONFIG_HOME/nvim/plugins/$rc
done

# Utility scripts
mkdir -p $HOME/.scripts
ln -sf `pwd`/.scripts/cmdnotif.sh $HOME/.scripts/cmdnotif.sh

# alacritty config file
mkdir -p $XDG_CONFIG_HOME/alacritty/
ln -sf `pwd`/.config/alacritty/alacritty.yml $XDG_CONFIG_HOME/alacritty/alacritty.yml
