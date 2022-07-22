export EDITOR=nvim

# postgres
export PGDATA="/usr/local/var/postgres"

# Programming languages
# --------------------------------------------------
# php
export PATH="/usr/local/opt/php@7.2/bin:$PATH"
export PATH="/usr/local/opt/php@7.2/sbin:$PATH"
# /usr/local/Cellar/php/7.4.4/bin

# Go lang(Set GOPATH)
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN

# Virtual Environments
# poetry
export PATH="$HOME/.poetry/bin:$PATH"

# exenv
export PATH="$HOME/.exenv/bin:$PATH"

# Tools
# --------------------------------------------------
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
