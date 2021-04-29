
export LS_COLORS="di=01;32;"
export EXA_COLORS="da=36"

export PATH="/Users/yusuk/.scripts:$PATH"

if [ -e $(brew --prefix)/share/zsh-completions ]; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
fi

##########################################################
# Programing Languages
##########################################################
# php
export PATH="/usr/local/opt/php@7.2/bin:$PATH"
export PATH="/usr/local/opt/php@7.2/sbin:$PATH"
# /usr/local/Cellar/php/7.4.4/bin

# Go lang(Set GOPATH)
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN

##########################################################
# Virtual Environments
##########################################################
# jenv
export PATH="$HOME/.jenv/bin:$PATH"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/zlib/lib -L/usr/local/opt/bzip2/lib"
export CPPFLAGS="-I/usr/local/opt/zlib/include -I/usr/local/opt/bzip2/include"

# nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH

# exenv
export PATH="$HOME/.exenv/bin:$PATH"

##########################################################
# Development Tools
##########################################################
# Android SDK
export ANDROID_SDK_HOME=/Users/yusuk/Library/Android/sdk
export ANDROID_HOME=/Users/yusuk/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

# react-native
export PATH="/usr/local/share/npm/bin:$PATH"
export PATH=${PATH}:${HOME}/node_modules/.bin
if [ -d ${HOME}/node_modules/.bin ]; then
    export PATH=${PATH}:${HOME}/node_modules/.bin
fi

# poetry
export PATH="$HOME/.poetry/bin:$PATH"

# postgres
export PGDATA="/usr/local/var/postgres"

# neovim
export XDG_CONFIG_HOME=$HOME/.config

# nnn
export NNN_FIFO=/tmp/nnn.fifo
export NNN_PLUG='f:finder;o:fzopen;p:preview-tui-ext;d:diffs;t:nmount;v:imgview'

