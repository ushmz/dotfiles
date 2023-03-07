#!/usr/bin/env sh -Cue

# zsh plugins
mkdir -p ${HOME}/.cache
git clone https://github.com/hlissner/zsh-autopair ${HOME}/.cache/zsh-autopair
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${HOME}/.cache/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${HOME}/.cache/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-completions.git ${HOME}/.cache/zsh-completions

if [ "$(uname)" != "Darwin" ]; then
    exit 1
fi

function open_appstore() {
    echo "Make sure you're logged in with your Apple ID"
    sleep 1; open -a "App Store"
}

function confirm_login() {
    while true; do
        echo "$* [Y/n]: (default: n) "
        read ANS
        case ${ANS} in
            [Yy]*)
                return 0
                ;;
            *)
                open_appstore
                ;;
        esac
    done
}

brew update

open_appstore
if confirm_login "Are you logged in with your Apple ID?"; then
    brew bundle
    brew cleanup
fi

# Install poetry
if !(type poetry &>/dev/null); then
  curl -sSL https://install.python-poetry.org | python3 -
fi
