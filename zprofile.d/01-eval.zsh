if type gdircolors &>/dev/null; then
    eval $(gdircolors)
fi

# Setting up brew PATH and environment variables
if [ -e /opt/homebrew/bin/brew ]; then
    eval $(/opt/homebrew/bin/brew shellenv)
fi

# cargo env
if [ -n "${CARGO_HOME}" ]; then
    source "${CARGO_HOME}/env"
fi
