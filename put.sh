#!/bin/sh

if [ -L $HOME/.zprofile ]; then
    unlink $HOME/.zprofile
fi
echo "#\!/bin/zsh\nfor i in \$(command ls `pwd`/zprofile.d/*.zsh | sort)\ndo\n  source \$i\ndone" > $HOME/.zprofile

# Remove `~/.zshrc` if exists, and write my `.zshrc`.
if [ -L $HOME/.zshrc ]; then
    unlink $HOME/.zshrc
fi
echo "#\!/bin/zsh\nfor i in \$(command ls `pwd`/zshrc.d/*.zsh | sort)\ndo\n  source \$i\ndone" > $HOME/.zshrc

# Put symbolic links.
# .gitmessage
ln -sf `pwd`/.gitmessage $HOME/.gitmessage

# .gitignore_global and source it.
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

# vscode setting file
mkdir -p "$HOME/.vscode/"
ln -sf `pwd`/vscode/settings.json $HOME/.vscode/setting.json

# nvim config files
# dein plugin files
mkdir -p $XDG_CONFIG_HOME/nvim/
ln -sf `pwd`/.config/nvim/init.vim $XDG_CONFIG_HOME/nvim/init.vim
ln -sf `pwd`/.config/nvim/dein.toml $XDG_CONFIG_HOME/nvim/dein.toml
ln -sf `pwd`/.config/nvim/dein_lazy.toml $XDG_CONFIG_HOME/nvim/dein_lazy.toml

# coc setting file
ln -sf `pwd`/.config/nvim/coc-settings.json $XDG_CONFIG_HOME/nvim/coc-settings.json

# vim color file
mkdir -p "$XDG_CONFIG_HOME/nvim/colors"
ln -sf `pwd`/.config/nvim/colors/hybrid.vim $XDG_CONFIG_HOME/nvim/colors/hybrid.vim

# vim plugin `run command` files
mkdir -p "$XDG_CONFIG_HOME/nvim/plugins"
ln -sf `pwd`/.config/nvim/plugins/coc.rc.vim $XDG_CONFIG_HOME/nvim/plugins/coc.rc.vim
ln -sf `pwd`/.config/nvim/plugins/defx.rc.vim $XDG_CONFIG_HOME/nvim/plugins/defx.rc.vim
ln -sf `pwd`/.config/nvim/plugins/denite.rc.vim $XDG_CONFIG_HOME/nvim/plugins/denite.rc.vim
ln -sf `pwd`/.config/nvim/plugins/silicon.rc.vim $XDG_CONFIG_HOME/nvim/plugins/silicon.rc.vim

# Utility scripts
ln -sf `pwd`/.scripts/cmdnotif.sh $HOME/.scripts/cmdnotif.sh
ln -sf `pwd`/.scripts/mux.sh $HOME/.scripts/mux.sh
ln -sf `pwd`/.scripts/typo.sh $HOME/.scripts/typo.sh
ln -sf `pwd`/.scripts/ssh_change_profile.sh $HOME/.scripts/ssh_change_profile.sh

