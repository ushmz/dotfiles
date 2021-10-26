#!/bin/sh
set -e

# ----------------------------------------------------------
# Remove `~/.zprofile` if exists, and write my `.zprofile`.
# ----------------------------------------------------------
if [ -L $HOME/.zprofile ]; then
    unlink $HOME/.zprofile
fi
ln -sf `pwd`/.zprofile.linux $HOME/.zprofile

# ----------------------------------------------------
# Remove `~/.zshrc` if exists, and write my `.zshrc`.
# ----------------------------------------------------
if [ -L $HOME/.zshrc ]; then
    unlink $HOME/.zshrc
fi
ln -sf `pwd`/.zshrc.linux $HOME/.zshrc

# Put symbolic links.

# ------------------------
# .gitmessage
# ------------------------
ln -sf `pwd`/.gitmessage $HOME/.gitmessage

# ------------------------
# .gitignore_global
# ------------------------
ln -sf `pwd`/.gitignore_global $HOME/.gitignore_global
git config --global core.excludesfile $HOME/.gitignore_global	

# ------------------------
# .tmux.conf
# ------------------------
ln -sf `pwd`/.tmux.conf.linux $HOME/.tmux.conf

# ------------------------
# starship.toml
# ------------------------
ln -sf `pwd`/.config/starship.toml $XDG_CONFIG_HOME/starship.toml

# ------------------------
# vim config files
# ------------------------
# vim color file
mkdir -p "$XDG_CONFIG_HOME/nvim/colors"
ln -sf `pwd`/.config/nvim/colors/hybrid.vim $XDG_CONFIG_HOME/nvim/colors/hybrid.vim

ln -sf `pwd`/.vimrc $HOME/.vimrc

# vim skeleton files
mkdir -p $XDG_CONFIG_HOME/nvim/templates
ln -sf `pwd`/.config/nvim/templates/skeleton.sh $XDG_CONFIG_HOME/nvim/templates/skeleton.sh

# ------------------------
# Utility scripts
# ------------------------
ln -sf `pwd`/.scripts/cmdnotif.sh $HOME/.scripts/cmdnotif.sh
