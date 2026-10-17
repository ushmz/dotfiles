# poetry completion
fpath+=(${XDG_CONFIG_HOME}/poetry/.zfunc(N-/))

# Activate a python venv: `venv [dir]` (defaults to .venv or venv)
function venv() {
    local dir
    if [[ -n ${1} ]]; then
        dir=${1}
    elif [[ -d ./.venv ]]; then
        dir=.venv
    elif [[ -d ./venv ]]; then
        dir=venv
    else
        echo 'Cannot find python venv.' >&2
        return 1
    fi
    source ./${dir}/bin/activate
}
