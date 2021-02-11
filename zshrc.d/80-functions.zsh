
# save dirstack to ~/.cache/shell
# mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}/shell"
# touch "${XDG_CACHE_HOME:-$HOME/.cache}/shell/$HOST.dirstack"
# my_save_dirstack () {
#     dirstack=(${(@u)$(<"${XDG_CACHE_HOME:-$HOME/.cache}/shell/$HOST.dirstack")})
#     dirs -lp >! "${XDG_CACHE_HOME:-$HOME/.cache}/shell/$HOST.dirstack"
# }
# chpwd_functions+=my_save_dirstack
# my_save_dirstack

##########################################################
# typo hook
##########################################################
function command_not_found_handler(){
    if [ -e ~/bin/typo.sh ]; then
        ~/bin/typo.sh
    else
        echo "Command $0 not found."
    fi
    return 127
}

function googleit() {
    IFS="+$IFS"
    brave "https://www.google.com/search?q=$*" 1>/dev/null 2>&1
    IFS=${IFS#?}
}
alias what="googleit"

function itermprof() { echo -ne "\033]1337;SetProfile=$@\a" }

function tmux_session() {
    if [ -n "$TMUX" ]; then
        tm "$@"
	return 0
    fi

    if [ -n "$1" ]; then
	if [ -n "$2" ]; then
	    itermprof "$2"
	    tmux new -d -s "${1}-${2}"
	    tmux send-keys -t "${1}-${2}" "tm ${1} ${2}" C-m
	    tmux attach-session -t "${1}-${2}"
	    itermprof kahma
	else
	    tmux new -d -s $1
	    tmux send-keys -t $1 "tm $1" C-m
	    tmux attach-session -t $1
	fi
    else
	tmux
    fi
}
alias mux='tmux_session'

