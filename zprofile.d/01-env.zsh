
export LS_COLORS="di=01;32;"
export EXA_COLORS="da=36"

export PATH="$HOME/.scripts:$PATH"
export PATH="$HOME/.local/bin:$PATH"

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

# asdf (Language version manager)
. /usr/local/opt/asdf/libexec/asdf.sh

# asdf jenv
. ~/.asdf/plugins/java/set-java-home.zsh

##########################################################
# Development Tools
##########################################################
# Android SDK
export ANDROID_SDK_HOME=/Users/ushmz/Library/Android/sdk
export ANDROID_HOME=/Users/ushmz/Library/Android/sdk
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

# XDG_CONFIG_HOME
export XDG_CONFIG_HOME=$HOME/.config

# nnn
export NNN_FIFO=/tmp/nnn.fifo
export NNN_PLUG='f:finder;o:fzopen;p:preview-tui-ext;d:diffs;t:nmount;v:imgview'

