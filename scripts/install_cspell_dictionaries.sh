#!/usr/bin/env bash

if type npm &>/dev/null; then
    jq -r '.import[]' ~/.config/cspell/cspell.json \
        | sed -e 's#\(dict-.*\)/.*.json$#\1#' \
        | xargs npm i -g
fi
