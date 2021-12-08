#!/bin/sh
set -e

mkdir -p $HOME/.config
mkdir -p $HOME/.cache/shell

# ----------------------------------------------------------
# Remove `~/.zprofile` if exists, and write my `.zprofile`.
# ----------------------------------------------------------
if [ -L $HOME/.zprofile ]; then
    unlink $HOME/.zprofile
fi

touch $HOME/.zprofile
echo "export LS_COLORS=\"di=01;32;\"" >> $HOME/.zprofile
echo "export PATH=\"\$HOME/.scripts:\$PATH\"" >> $HOME/.zprofile
echo "# HOME/.config" >> $HOME/.zprofile 
echo "export HOME/.config=\$HOME/.config" >> $HOME/.zprofile

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
echo "source `pwd`/zshrc.d/50-alias.zsh" >> $HOME/.zshrc
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
ln -sf `pwd`/.config/starship.toml $HOME/.config/starship.toml

# vim config file
ln -sf `pwd`/.vimrc $HOME/.vimrc

# vim color file
mkdir -p "$HOME/.vim/colors"
ln -sf `pwd`/.config/nvim/colors/hybrid.vim $HOME/.vim/colors/hybrid.vim
ln -sf `pwd`/.config/nvim/colors/hybrid.vim $HOME/.config/nvim/colors/hybrid.vim

# vim skeleton files
mkdir -p $HOME/.config/nvim/templates
ln -sf `pwd`/.config/nvim/templates/skeleton.sh $HOME/.vim/templates/skeleton.sh
ln -sf `pwd`/.config/nvim/templates/skeleton.sh $HOME/.config/nvim/templates/skeleton.sh

# Utility scripts
mkdir -p $HOME/.scripts
ln -sf `pwd`/.scripts/cmdnotif.sh $HOME/.scripts/cmdnotif.sh
