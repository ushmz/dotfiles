#!/usr/bin/env sh
set -Cue

# Install xcode command line tools
if [ "$(uname)" = "Darwin" ]; then
    xcode-select --install

    # If you use Apple Silicon, install Rosetta2
    if [ "$(uname -m)" = "arm64" ]; then
        /usr/sbin/softwareupdate --install-rosetta --agree-to-license
    fi
fi

# Install zsh plugins and brew formulae
sh ../scripts/install.sh

# Setup asdf and install necessary versions
sh ../scripts/asdf-setup.sh

# Configure Mac settings
sh ../scripts/defaults.sh
