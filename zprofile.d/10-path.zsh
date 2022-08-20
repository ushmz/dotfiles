# Programming languages
# --------------------------------------------------
export ANDROID_SDK_HOME=${HOME}/Library/Android/sdk
export ANDROID_HOME=${HOME}/Library/Android/sdk

path+=(
    # Original scripts
    "$HOME/.scripts"(N-/)
    # local packages
    "$HOME/.local/bin"(N-/)
    # php
    "/usr/local/opt/php@7.2/bin"(N-/)
    "/usr/local/opt/php@7.2/sbin"(N-/)
    # python
    "${HOME}/.asdf/installs/python/3.10.0/bin"(N-/)
    # poetry
    "${HOME}/.poetry/bin"(N-/)
    # exenv
    "${HOME}/.exenv/bin"(N-/)
    # Android SDK
    "${ANDROID_HOME}/emulator"(N-/)
    "${ANDROID_HOME}/tools"(N-/)
    "${ANDROID_HOME}/tools/bin"(N-/)
    "${ANDROID_HOME}/platform-tools"(N-/)
    # react-native
    "/usr/local/share/npm/bin"(N-/)
    "${HOME}/node_modules/.bin"(N-/)

    # Remote server
    "/usr/local/pyenv/shims"(N-/)
    "/usr/local/pyenv/bin"(N-/)
)
