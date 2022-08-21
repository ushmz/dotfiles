export LS_COLORS="di=01;32;"
export EXA_COLORS="da=36"

export EDITOR=nvim

# XDG_CONFIG_HOME
export XDG_CONFIG_HOME=${HOME}/.config
export XDG_STATE_HOME=${HOME}/.local/state
export XDG_DATA_HOME=${HOME}/.local/share
export XDG_CACHE_HOME=${HOME}/.cache

# Stop dirtying Home directory
export HISTFILE="${XDG_STATE_HOME}/zsh_history"
export NODE_REPL_HISTORY="${XDG_STATE_HOME}/node_history"
export SQLITE_HISTORY="${XDG_STATE_HOME}/sqlite_history"
export MYSQL_HISTFILE="${XDG_STATE_HOME}/mysql_history"
export PSQL_HISTORY="${XDG_STATE_HOME}/psql_history"
export SQLITE_HISTORY="${XDG_DATA_HOME}/sqlite_history"
export PYTHONSTARTUP="${XDG_CONFIG_HOME}/python/pythonrc"
export IPYTHONDIR="${XDG_CONFIG_HOME}/jupyter"
export JUPYTER_CONFIG_DIR="${XDG_CONFIG_HOME}/jupyter"
export WGETRC="${XDG_CONFIG_HOME}/wgetrc"
# export GOPATH="$XDG_DATA_HOME/go"

# Go lang(Set GOPATH)
export GOPATH=${HOME}/go
export GOBIN=${GOPATH}/bin
export PATH=${PATH}:${GOBIN}

# postgres
export PGDATA="/usr/local/var/postgres"

# cargo env
source "${HOME}/.cargo/env"
