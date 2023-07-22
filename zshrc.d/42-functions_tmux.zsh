# tmux pane layout presets
function split_tmux_pane() {
    if [ -z "$TMUX" ]; then
        echo "Attach into tmux session."
        exit 1
    fi

    if [ "$#" -eq 0 ]; then
        tmux split-window -v
        tmux split-window -h
        tmux resize-pane -D 15
        tmux select-pane -D
        clear
    else
        case "$1" in
        "ide")
            tmux split-window -v
            tmux split-window -h
            tmux resize-pane -D 15
            tmux select-pane -D
            tmux split-window -h
            tmux select-pane -D
            clear
            ;;
        "dev")
            tmux split-window -v
            tmux split-window -h
            tmux resize-pane -D 15
            tmux resize-pane -R 50
            tmux last-pane
            tmux split-pane -h
            tmux select-pane -D
            # tmux split-window -h
            # tmux resize-pane -R 40
            # tmux last-pane
            clear
            ;;
        "simple")
            tmux split-window -v
            tmux split-window -h
            tmux resize-pane -D 15
            tmux select-pane -D
            clear
            ;;
        "remote")
            tmux split-window -h
            tmux split-window -v
            tmux resize-pane -D 15
            tmux select-pane -t 0
            clear
            if [ -n "$2" ]; then
                /usr/bin/ssh "$2"
            fi
            ;;
        *)
            echo "[ERROR] Unknown argument: ${1}"
            ;;
        esac
    fi
}

# (Make tmux session if needed) and split pane
function split_pane() {
    if [ -n "$TMUX" ]; then
        split_tmux_pane "$@"
        return 0
    fi

    if [ -n "$1" ]; then
        if [ -n "$2" ]; then
            itermprof "$2"
            tmux new -d -s "${1}-${2}"
            tmux send-keys -t "${1}-${2}" "split_tmux_pane ${1} ${2}" C-m
            tmux attach-session -t "${1}-${2}"
        else
            tmux new -d -s "${1}-${PWD##*/}"
            tmux send-keys -t "${1}-${PWD##*/}" "split_tmux_pane $1" C-m
            tmux attach-session -t "${1}-${PWD##*/}"
        fi
    else
        tmux
    fi
}
alias tm='split_pane'
