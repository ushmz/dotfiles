#!/usr/bin/env sh
set -Cue

if ! (type brew >/dev/null 2>&1); then
    printf '\033[1m[ERROR]\033[31m command `brew` not found.\n' >&2
    exit 1
fi

# brew tap
echo "# Taps"
brew tap | sed -r "s/(.*)/tap \'\1\'/"

# formulae
# NOTE: Formulae from untrusted taps are silently dropped by `brew leaves`;
formulae=$(brew leaves -r | xargs brew info --json=v2)
echo "\n# Formulae"
printf '%s\n' "${formulae}" \
    | jq -r '.formulae[] | "'"'"'\(.full_name)'"'"'\t# \(.desc // "")"' \
    | column -t -s "$(printf '\t')" | sed -r "s/(.*)/brew \1/"

# casks
casks=$(brew info --json=v2 --cask --installed)
echo "\n# Casks"
printf '%s\n' "${casks}" \
    | jq -r '.casks[] | "'"'"'\(.full_token)'"'"'\t# (\(.name | join(", "))) \(.desc // "")"' \
    | sed -E 's/ +$//' | column -t -s "$(printf '\t')" | sed -r "s/(.*)/cask \1/"

# mas
if ! (type mas >/dev/null 2>&1); then
    printf '\033[1m\033[33m[WARN]\033[0m command `mas` not found. Skipped.\n' >&2
    exit 0
fi

echo "\n# Mac App Store"
mas list | sed -r 's/\ {2,}/\t/g' | sed -r "s/(.+)\t(.+)\t.*/mas '\2', id: \1/"
