#!/usr/bin/env sh
set -Cue

ghlink() {
    echo "[${0}](https://github.com/${0})"
}

for plugin in ~/.config/nvim/lua/plugins/configs/**/init.lua; do
    rg -I --hidden --engine auto '"[\S\d]+\/[\S\d]+"' "${plugin}" |
        tr -d '\t' |
        grep -v '~' |
        grep '^[{|"]' |
        sort |
        sed -n '/{.*}/s/.*"\([^"]*\/[^"]*\)".*/\t- \[\1\]\(https\:\/\/github.com\/\1\)/p; /{.*}/!p' |
        sed 's/"\([^{}]*\)",/- \[\1\]\(https:\/\/github.com\/\1\)/g' |
        uniq
done

for plugin in ~/.config/nvim/lua/plugins/configs/*.lua; do
    rg -I --hidden --engine auto '"[\S\d]+\/[\S\d]+"' "${plugin}" |
        tr -d '\t' |
        grep -v '~' |
        grep '^[{|"]' |
        sort |
        sed -n '/{.*}/s/.*"\([^"]*\/[^"]*\)".*/\t- \[\1\]\(https\:\/\/github.com\/\1\)/p; /{.*}/!p' |
        sed 's/"\([^{}]*\)",/- \[\1\]\(https:\/\/github.com\/\1\)/g' |
        uniq
done
