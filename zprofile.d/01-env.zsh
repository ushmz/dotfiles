export LS_COLORS="di=01;32;"
export EXA_COLORS="da=36"

export EDITOR=nvim

# XDG_CONFIG_HOME
export XDG_CONFIG_HOME=${HOME}/.config
export XDG_STATE_HOME=${HOME}/.local/state
export XDG_DATA_HOME=${HOME}/.local/share
export XDG_CACHE_HOME=${HOME}/.cache

# Stop dirtying Home directory
export CARGO_HOME="${XDG_DATA_HOME}/cargo"
export DOCKER_CONFIG="${XDG_CONFIG_HOME}/docker"
export FFMPEG_DATADIR="${XDG_CONFIG_HOME}/ffmpeg"
export HISTFILE="${XDG_STATE_HOME}/zsh_history"
export IPYTHONDIR="${XDG_CONFIG_HOME}/jupyter"
export JUPYTER_CONFIG_DIR="${XDG_CONFIG_HOME}/jupyter"
export MYSQL_HISTFILE="${XDG_STATE_HOME}/mysql_history"
export NODE_REPL_HISTORY="${XDG_STATE_HOME}/node_history"
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/npmrc"
export NUGET_PACKAGES="${XDG_CACHE_HOME}/NuGetPackages"
export PSQL_HISTORY="${XDG_STATE_HOME}/psql_history"
export PYLINTHOME="${XDG_CACHE_HOME}/pylint"
export PYLINTRC="${XDG_CONFIG_HOME}/pylint/pylintrc"
export PYTHONSTARTUP="${XDG_CONFIG_HOME}/python/pythonrc"
export REDISCLI_HISTFILE="${XDG_DATA_HOME}/redis/rediscli_history"
export REDISCLI_RCFILE="${XDG_CONFIG_HOME}/redis/redisclirc"
export RUSTUP_HOME="${XDG_DATA_HOME}/rustup"
export SQLITE_HISTORY="${XDG_STATE_HOME}/sqlite_history"
export STACK_ROOT="${XDG_DATA_HOME}/stack"
export STARSHIP_CONFIG="${XDG_CONFIG_HOME}/starship.toml"
export STARSHIP_CACHE="${XDG_CACHE_HOME}/starship"
export VAGRANT_HOME="${XDG_DATA_HOME}/vagrant"
export VAGRANT_ALIAS_FILE="${XDG_DATA_HOME}/vagrant/aliases"
export WGETRC="${XDG_CONFIG_HOME}/wgetrc"
# export GOPATH="$XDG_DATA_HOME/go"

# Go lang(Set GOPATH)
export GOPATH=${HOME}/go
export GOBIN=${GOPATH}/bin
export PATH=${PATH}:${GOBIN}

# postgres
export PGDATA="/usr/local/var/postgres"

# cargo env
source "${CARGO_HOME}/env"
