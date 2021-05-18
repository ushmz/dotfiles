
# save dirstack to ~/.cache/shell
# mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}/shell"
# touch "${XDG_CACHE_HOME:-$HOME/.cache}/shell/$HOST.dirstack"
# my_save_dirstack () {
#     dirstack=(${(@u)$(<"${XDG_CACHE_HOME:-$HOME/.cache}/shell/$HOST.dirstack")})
#     dirs -lp >! "${XDG_CACHE_HOME:-$HOME/.cache}/shell/$HOST.dirstack"
# }
# chpwd_functions+=my_save_dirstack
# my_save_dirstack

# typo hook
function command_not_found_handler(){
    if [ -e ~/.scripts/typo.sh ]; then
        ~/.scripts/typo.sh
    else
        echo "Command $0 not found."
    fi
    return 127
}

# Google it func
function googleit() {
    IFS="+$IFS"
    brave "https://www.google.com/search?q=$*" 1>/dev/null 2>&1
    IFS=${IFS#?}
}
alias what="googleit"

# Change iTerm profile
function itermprof() { echo -ne "\033]1337;SetProfile=$@\a" }

# (Make tmux session if needed) and split pane
function tmux_session() {
    if [ -n "$TMUX" ]; then
        mux.sh "$@"
	return 0
    fi

    if [ -n "$1" ]; then
		if [ -n "$2" ]; then
	    	itermprof "$2"
		    tmux new -d -s "${1}-${2}"
		    tmux send-keys -t "${1}-${2}" "mux.sh ${1} ${2}" C-m
	    	tmux attach-session -t "${1}-${2}"
		    itermprof kahma
		else
	    	tmux new -d -s "${1}-${PWD##*/}"
	    	tmux send-keys -t "${1}-${PWD##*/}" "mux.sh $1" C-m
	    	tmux attach-session -t "${1}-${PWD##*/}"
		fi
    else
    	tmux
    fi
}
alias mux='tmux_session'

# `track` is online coding examination platform.
# `track-cli` is interface that I can take exam in local machine.
function uninstall_track_cli() {
	rm /usr/local/bin/track
}

function sourse_pyenv() {
    if [[  -f './.venv' ]]; then
        source ./.venv/bin/activate
    else
        echo 'Connot find pyenv environment.'
    fi
}
alias venv='sourse_pyenv'

function pslist() {
    ps aux | peco | awk '{print $2}'
}
