#!/usr/bin/env sh
set -Cue

# Make directories for dotfiles
mkdir -p "${HOME}/.config"
mkdir -p "${HOME}/.local/state"
mkdir -p "${HOME}/.local/share"
mkdir -p "${HOME}/.cache"

# Install xcode command line tools
if [ "$(uname)" = "Darwin" ]; then
    xcode-select --install

    # If you use Apple Silicon, install Rosetta2
    if [ "$(uname -m)" = "arm64" ]; then
        /usr/sbin/softwareupdate --install-rosetta --agree-to-license
    fi
fi

# Install brew
if ! (type brew 1>/dev/null); then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

    if [ "$(uname)" = "Darwin" ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)" >/dev/null
    else
        # Install dependency
        sudo apt-get install build-essential
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" >/dev/null
    fi

    brew analytics off

    # Reccomended tool
    brew install gcc
fi
