#!/usr/bin/env bash

fn() {
    git rev-parse --abbrev-ref origin/HEAD |
        sed 's/\// /' |
        git fetch ${1:"awk '{print $1}'"} && git rebase ${1:"awk '{print $1}'"}/${2:"awk '{print $2}'"} --autostash
}

fn "$@"
