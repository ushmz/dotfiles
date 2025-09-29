if type gdircolors &>/dev/null; then
	eval $(gdircolors)
fi

# Setting up brew PATH and environment variables
if [ -e /opt/homebrew/bin/brew ]; then
	eval $(/opt/homebrew/bin/brew shellenv)
elif [ -e /home/linuxbrew/.linuxbrew/bin/brew ]; then
	eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
fi

# cargo env
if [ -n "${CARGO_HOME}" ]; then
	# shellcheck source=/dev/null
	# source "${CARGO_HOME}/env"
fi

# kiro shell integration
[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"
