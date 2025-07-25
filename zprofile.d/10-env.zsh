export EDITOR=nvim

export TMUX_SHELL=$(which zsh)

# XDG_CONFIG_HOME
export XDG_CONFIG_HOME=${HOME}/.config
export XDG_STATE_HOME=${HOME}/.local/state
export XDG_DATA_HOME=${HOME}/.local/share
export XDG_CACHE_HOME=${HOME}/.cache

export DOCKER_CONFIG="${XDG_CONFIG_HOME}/docker"
export FFMPEG_DATADIR="${XDG_CONFIG_HOME}/ffmpeg"
export IPYTHONDIR="${XDG_CONFIG_HOME}/jupyter"
export JUPYTER_CONFIG_DIR="${XDG_CONFIG_HOME}/jupyter"
export LESSKEY=${XDG_CONFIG_HOME}/less/lesskey
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/npmrc"
export PYLINTRC="${XDG_CONFIG_HOME}/pylint/pylintrc"
export PYTHONSTARTUP="${XDG_CONFIG_HOME}/python/pythonrc.py"
export REDISCLI_RCFILE="${XDG_CONFIG_HOME}/redis/redisclirc"
export STARSHIP_CONFIG="${XDG_CONFIG_HOME}/starship.toml"
export WGETRC="${XDG_CONFIG_HOME}/wgetrc"

export HISTSIZE=100000  # save in RAM
export SAVEHIST=1000000 # save in file
export HISTFILE="${XDG_STATE_HOME}/.zsh_history"
export MYSQL_HISTFILE="${XDG_STATE_HOME}/.mysql_history"
export NODE_REPL_HISTORY="${XDG_STATE_HOME}/.node_history"
export PSQL_HISTORY="${XDG_STATE_HOME}/.psql_history"
export SQLITE_HISTORY="${XDG_STATE_HOME}/.sqlite_history"

export CARGO_HOME="${XDG_DATA_HOME}/cargo"
export REDISCLI_HISTFILE="${XDG_DATA_HOME}/redis/rediscli_history"
export RUSTUP_HOME="${XDG_DATA_HOME}/rustup"
export STACK_ROOT="${XDG_DATA_HOME}/stack"
export VAGRANT_HOME="${XDG_DATA_HOME}/vagrant"
export VAGRANT_ALIAS_FILE="${XDG_DATA_HOME}/vagrant/aliases"

export NUGET_PACKAGES="${XDG_CACHE_HOME}/NuGetPackages"
export PYLINTHOME="${XDG_CACHE_HOME}/pylint"
export STARSHIP_CACHE="${XDG_CACHE_HOME}/starship"

# Go lang(Set GOPATH)
export GOPATH=${XDG_DATA_HOME}/go
export GOBIN=${GOPATH}/bin

# android
# export ANDROID_SDK_HOME=${HOME}/Library/Android/sdk
export ANDROID_HOME=${HOME}/Library/Android/sdk

# fzf default options
export FZF_DEFAULT_OPTS='--height=40% --layout=reverse --tabstop=4 --info=right --no-mouse'


# asdf data directory
export ASDF_DATA_DIR="${XDG_DATA_HOME}/asdf"
