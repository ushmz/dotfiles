#!/usr/bin/env sh
set -Cue

# Setup asdf
if [ "$(uname)" = "Darwin" ]; then
    brew install openssl readline libyaml
else
    sudo apt install -y \
        autoconf \
        bison \
        build-essential \
        libssl-dev \
        libyaml-dev \
        libreadline6-dev \
        zlib1g-dev \
        libncurses5-dev \
        libffi-dev \
        libgdbm6 \
        libgdbm-dev \
        libdb-dev
fi

asdf plugin add java
asdf plugin add nodejs
asdf plugin add python
asdf plugin add ruby
asdf plugin add deno
asdf plugin add poetry

# Install them as necessary
asdf install nodejs 20.19.4
asdf install nodejs 22.17.1
asdf install nodejs 23.11.1
asdf install nodejs 24.4.1
asdf install python 3.8.20
asdf install python 3.11.13
asdf install python 3.13.5
asdf install ruby 3.2.8
asdf install ruby 3.4.5
asdf install deno 2.4.2
asdf install poetry 2.1.3
