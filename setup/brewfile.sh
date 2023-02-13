#!/bin/sh -Cue

if !(type brew &>/dev/null); then
	echo 'command brew not found'
    exit 1
fi

if !(type mas &>/dev/null); then
    echo 'command mas not found'
    exit 1
fi

# brew tap
brew tap-info --installed | grep ' formula' | cut -d ':' -f 1 | sed -r "s/(.*)/tap \'\1\'/"

# formulae
brew leaves | sed -r "s/(.*)/brew \'\1\'/"

# casks
brew list --cask | sed -r "s/(.*)/cask \'\1\'/"

# mas
mas list | sed -r 's/\ {2,}/\t/g' | sed -r "s/(.+)\t(.+)\t.*/mas '\2', id: \1/"
