#!/bin/sh -Cue

if !(type brew &>/dev/null); then
	echo 'command brew not found'
    exit 1
fi

if !(type mas &>/dev/null); then
    echo 'command mas not found'
    exit 1
fi

for tap in $(brew tap-info --installed | grep ' formula' | cut -d ':' -f 1); do
    echo tap \'${tap}\'
done

for formula in $(brew leaves); do
    echo brew \'${formula}\'
done

for cask in $(brew list --cask); do
	echo cask \'${cask}\'
done

mas list | sed 's/\ /\ \t#/' | sed 's/\ \ /\ /' | sed 's/\(.\)\s*(/\1 (/' | sed 's/^/mas /'
