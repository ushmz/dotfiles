#!/usr/bin/env sh -Cue

# Make direcories for dotfiles
mkdir -p ${HOME}/.config
mkdir -p ${HOME}/.local/state
mkdir -p ${HOME}/.local/share
mkdir -p ${HOME}/.cache

if [ "$(uname)" != "Darwin" ]; then
    exit 1
fi

# If you use Apple Silicon, install Rosetta2
if [ "$(uname -m)" = "arm64" ]; then
    /usr/sbin/softwareupdate --install-rosetta --agree-to-license
fi

# Install xcode command line tools
xcode-select --install


# Install brew
if !(type brew &>/dev/null); then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)" > /dev/null
fi

brew analytics off
