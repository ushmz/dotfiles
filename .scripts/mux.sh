#!/bin/zsh

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
    "pro")
      tmux split-window -h
      tmux split-window -v
      tmux resize-pane -D 15
      tmux select-pane -t 1
      tmux split-window -v
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
    "xremote")
      tmux split-window -h
      tmux split-window -v
      tmux resize-pane -D 15
      tmux select-pane -t 0
      tmux split-window -v
      tmux select-pane -D
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
