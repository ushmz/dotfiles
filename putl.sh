#!/bin/sh
set -e

mkdir -p $HOME/.config
XDG_CONFIG_HOME=$HOME/.config

# ----------------------------------------------------------
# Remove `~/.zprofile` if exists, and write my `.zprofile`.
# ----------------------------------------------------------
if [ -L $HOME/.zprofile ]; then
    unlink $HOME/.zprofile
fi

touch $HOME/.zprofile
echo "export LS_COLORS=\"di=01;32;\"" >> $HOME/.zprofile
echo "export PATH=\"\$HOME/.scripts:\$PATH\"" >> $HOME/.zprofile
echo "# XDG_CONFIG_HOME" >> $HOME/.zprofile 
echo "export XDG_CONFIG_HOME=\$HOME/.config" >> $HOME/.zprofile

# ----------------------------------------------------
# Remove `~/.zshrc` if exists, and write my `.zshrc`.
# ----------------------------------------------------
if [ -L $HOME/.zshrc ]; then
    unlink $HOME/.zshrc
fi
touch $HOME/.zshrc
echo "#\!/bin/zsh" >> $HOME/.zshrc
echo "source `pwd`/zshrc.d/10-autoload.zsh" >> $HOME/.zshrc
echo "source `pwd`/zshrc.d/20-completion.zsh" >> $HOME/.zshrc
echo "source `pwd`/zshrc.d/30-setopt.zsh" >> $HOME/.zshrc
echo "source `pwd`/zshrc.d/60-alias.zsh" >> $HOME/.zshrc
echo "source \$HOME/.scripts/cmdnotif.sh" >> $HOME/.zshrc


# ----------------------------------------------------
# Put symbolic links.
# ----------------------------------------------------

# .gitmessage
ln -sf `pwd`/.gitmessage $HOME/.gitmessage

# .gitignore_global
ln -sf `pwd`/.gitignore_global $HOME/.gitignore_global
git config --global core.excludesfile $HOME/.gitignore_global	

# .tmux.conf
ln -sf `pwd`/.tmux.conf.linux $HOME/.tmux.conf

# starship.toml
ln -sf `pwd`/.config/starship.toml $XDG_CONFIG_HOME/starship.toml

# vim config file
ln -sf `pwd`/.vimrc $HOME/.vimrc

# vim color file
mkdir -p "$HOME/.vim/colors"
mkdir -p "$XDG_CONFIG_HOME/nvim/colors"
ln -sf `pwd`/.config/nvim/colors/hybrid.vim $HOME/.vim/colors/hybrid.vim
ln -sf `pwd`/.config/nvim/colors/hybrid.vim $XDG_CONFIG_HOME/nvim/colors/hybrid.vim

# vim skeleton files
mkdir -p $HOME/.vim/templates
mkdir -p $XDG_CONFIG_HOME/nvim/templates
ln -sf `pwd`/.config/nvim/templates/skeleton.sh $HOME/.vim/templates/skeleton.sh
ln -sf `pwd`/.config/nvim/templates/skeleton.sh $XDG_CONFIG_HOME/nvim/templates/skeleton.sh

# Utility scripts
mkdir -p $HOME/.scripts
ln -sf `pwd`/.scripts/cmdnotif.sh $HOME/.scripts/cmdnotif.sh
