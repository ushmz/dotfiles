#!/usr/bin/env sh
set -Cue

if ! (type brew 1>/dev/null); then
    printf '\033[1m[ERROR]\033[31m command `brew` not found.\n' >&2
    exit 1
fi

# brew tap
echo "# Taps"
brew tap | sed -r "s/(.*)/tap \'\1\'/"

# formulae
echo "\n# Formulae"
brew leaves | xargs brew desc | sed -E "s/^([^:]*):(.*)$/'\1'\:#\2/" | column -t -s ':' | sed -r "s/(.*)/brew \1/"

# casks
echo "\n# Casks"
brew list --cask | xargs brew desc | sed -E "s/^([^:]*):(.*)$/'\1'\:#\2/" | column -t -s ':' | sed -r "s/(.*)/cask \1/"

# mas
if ! (type mas 1>/dev/null); then
    printf '\033[1m\033[33m[WARN]\033[0m command `mas` not found. Skipped.\n' >&2
    exit 0
fi

echo "\n# Mac App Store"
mas list | sed -r 's/\ {2,}/\t/g' | sed -r "s/(.+)\t(.+)\t.*/mas '\2', id: \1/"
