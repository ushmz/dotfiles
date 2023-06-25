#!/usr/bin/env sh -Cue

function info() {
    echo -e "\033[0;34m- ${$1}\033[0m"
}

# Setup asdf
if [ $(uname) == "Darwin" ]; then
    brew install openssl readline
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

# Install them as necessary
asdf install nodejs 14.17.1
asdf install nodejs 16.17.0
asdf install python 3.6.15
asdf install python 3.8.16
asdf install python 3.11.2
asdf install ruby 3.0.3

# Generate SSH key
info "SSH setup"
SSH_KEY_PATH="${HOME}/.ssh"
if [ ! -e "${SSH_KEY_PATH}/id_rsa.pub" ]; then
    install -m 0700 -d ${SSH_KEY_PATH}
    ssh-keygen  -N '' -b 4096 -f ${SSH_KEY_PATH}/id_rsa
fi

# Set SSH key to github
pbcopy < ${SSH_KEY_PATH}/id_rsa.pub
info "SSH key copied to clipboard. Paste it into Github setting."
sleep 1; open 'https://github.com/settings/ssh/new'
