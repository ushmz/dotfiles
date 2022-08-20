export LS_COLORS="di=01;32;"
export EXA_COLORS="da=36"

export EDITOR=nvim

# XDG_CONFIG_HOME
export XDG_CONFIG_HOME=${HOME}/.config

# Go lang(Set GOPATH)
export GOPATH=${HOME}/go
export GOBIN=${GOPATH}/bin
export PATH=${PATH}:${GOBIN}

# postgres
export PGDATA="/usr/local/var/postgres"

# cargo env
source "${HOME}/.cargo/env"
