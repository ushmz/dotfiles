#!/usr/bin/env sh
set -Cue

# Make directories for dotfiles
mkdir -p "${HOME}/.config"
mkdir -p "${HOME}/.local/state"
mkdir -p "${HOME}/.local/share"
mkdir -p "${HOME}/.cache"
