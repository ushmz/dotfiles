#!/usr/bin/env sh
set -Cue

# zsh plugins
mkdir -p "${HOME}/.cache"
git clone https://github.com/hlissner/zsh-autopair "${HOME}/.cache/zsh-autopair"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${HOME}/.cache/zsh-syntax-highlighting"
git clone https://github.com/zsh-users/zsh-autosuggestions "${HOME}/.cache/zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-completions.git "${HOME}/.cache/zsh-completions"
git clone https://github.com/olets/zsh-abbr --single-branch --branch main --depth 1 "${HOME}/.cache/zsh-abbr"

# brew fomulae
brew update
if [ "$(uname)" = "Darwin" ]; then
    open_appstore() {
        echo "Make sure you're logged in with your Apple ID"
        sleep 1
        open -a "App Store"
    }

    confirm_login() {
        while true; do
            echo "$* [Y/n]: (default: n) "
            read -r ANS
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

    open_appstore
    if confirm_login "Are you logged in with your Apple ID?"; then
        brew bundle
    fi
else
    brew bundle --file LinuxBrewfile
fi

brew cleanup

# Install poetry
if ! (type poetry 1>/dev/null); then
    curl -sSL https://install.python-poetry.org | python3 -
fi
