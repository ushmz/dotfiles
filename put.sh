#!/bin/sh
set -e

export XDG_CONFIG_HOME=$HOME/.config

# ----------------------------------------------------------
# Remove `~/.zprofile` if exists, and write my `.zprofile`.
# ----------------------------------------------------------
if [ -L $HOME/.zprofile ]; then
    unlink $HOME/.zprofile
fi
echo "#\!/bin/zsh\nfor i in \$(command ls `pwd`/zprofile.d/*.zsh | sort)\ndo\n  source \$i\ndone" > $HOME/.zprofile

# ----------------------------------------------------
# Remove `~/.zshrc` if exists, and write my `.zshrc`.
# ----------------------------------------------------
if [ -L $HOME/.zshrc ]; then
    unlink $HOME/.zshrc
fi
echo "#\!/bin/zsh\nfor i in \$(command ls `pwd`/zshrc.d/*.zsh | sort)\ndo\n  source \$i\ndone" > $HOME/.zshrc

# ----------------------------------------------------
# Put symbolic links.
# ----------------------------------------------------

# .gitmessage
ln -sf `pwd`/.gitmessage $HOME/.gitmessage

# .gitignore_global
ln -sf `pwd`/.gitignore_global $HOME/.gitignore_global
git config --global core.excludesfile $HOME/.gitignore_global	

# alacritty config file
mkdir -p $XDG_CONFIG_HOME/alacritty/
ln -sf `pwd`/.config/alacritty/alacritty.yml $XDG_CONFIG_HOME/alacritty/alacritty.yml

# .tmux.conf
ln -sf `pwd`/.tmux.conf $HOME/.tmux.conf

# starship.toml
ln -sf `pwd`/.config/starship.toml $XDG_CONFIG_HOME/starship.toml

# .tigrc
ln -sf `pwd`/.tigrc $HOME/.tigrc

# ------------------------
# nvim config files
# ------------------------

mkdir -p $XDG_CONFIG_HOME/nvim/
ln -sf `pwd`/.config/nvim/init.vim $XDG_CONFIG_HOME/nvim/init.vim

# dein plugin files
ln -sf `pwd`/.config/nvim/dein.toml $XDG_CONFIG_HOME/nvim/dein.toml
ln -sf `pwd`/.config/nvim/dein_lazy.toml $XDG_CONFIG_HOME/nvim/dein_lazy.toml

# vim color file
mkdir -p "$XDG_CONFIG_HOME/nvim/colors"
ln -sf `pwd`/.config/nvim/colors/hybrid.vim $XDG_CONFIG_HOME/nvim/colors/hybrid.vim

# vim skeleton files
mkdir -p $XDG_CONFIG_HOME/nvim/templates
ln -sf `pwd`/.config/nvim/templates/skeleton.sh $XDG_CONFIG_HOME/nvim/templates/skeleton.sh

# coc setting file
ln -sf `pwd`/.config/nvim/coc-settings.json $XDG_CONFIG_HOME/nvim/coc-settings.json

# vim plugin `run command` files
mkdir -p "$XDG_CONFIG_HOME/nvim/plugins"
for rc in $(ls -I '*.md' `pwd`/.config/nvim/plugins/* | xargs -n 1 basename); do
    ln -sf `pwd`/.config/nvim/plugins/$rc $XDG_CONFIG_HOME/nvim/plugins/$rc
done

# VSCode config files
mkdir -p "$HOME/.vscode/"
ln -sf `pwd`/vscode/settings.json $HOME/.vscode/setting.json

# Utility scripts
for script in $(ls -I '*.md' `pwd`/.scripts/* | xargs -n 1 basename); do
    ln -sf `pwd`/.scripts/$script $HOME/.scripts/$script
done
