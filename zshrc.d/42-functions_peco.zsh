# Show ps with peco
function pslist() {
    ps aux | peco | awk '{print $2}'
}

# Search command history
function peco_select_history() {
  BUFFER=$(\history -n -r 1 | peco --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle reset-prompt
}

# Search distination from cdr list
function peco_get_destination_from_cdr() {
  cdr -l | \
  sed -e 's/^[[:digit:]]*[[:blank:]]*//' | \
  peco --query "$LBUFFER"
}

# Search directory from history
function peco_cdr() {
  local destination="$(peco_get_destination_from_cdr)"
  if [ -n "$destination" ]; then
    BUFFER="cd $destination"
    zle accept-line
  else
    zle reset-prompt
  fi
}

# Search tmux session
# | This cause freezing peco window...
# function peco_tmux_sessions() {
#  local res=$(tmux list-sessions | peco --query "$LBUFFER" | awk -F':' '{print $1}')
#   if [ -n "$res" ]; then
#     BUFFER="tmux attach -t $res"
#     CURSOR=$#BUFFER
#     zle clear-screen
#   else
#     zle reset-prompt
#   fi
# }

# Search by hostname from .ssh/config
function peco_ssh_host() {
  local res=$(grep "Host " ~/.ssh/config | grep -v '*' | cut -b 6- | peco)
  if [ -n "$res" ]; then
    BUFFER="ssh $res"
    CURSOR=$#BUFFER
    zle clear-screen
  else
    zle reset-prompt
  fi
}

# Search local repository from `ghq root`
function ghq_list() {
    local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
    if [ -n "$selected_dir" ]; then
      BUFFER="cd ${selected_dir}"
      zle accept-line
    fi
    zle clear-screen
}

# Open repository in `ghq root` with VSCode
function ghq_code() {
    local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
    if [ -n "$selected_dir" ]; then
      BUFFER="code ${selected_dir}"
      zle accept-line
    fi
    zle clear-screen
}

function edas() {
    git checkout `git branch | peco --prompt "GIT BRANCH>" | head -n 1 | sed -e "s/^\*\s*//g"`
}

function prune() {
    git branch -d `git branch | peco --prompt "GIT BRANCH>" | head -n 1 | sed -e "s/^\*\s*//g"`
}

function iterm() {
    echo -ne "\033]1337;SetProfile=$(peco ~/dotfiles/iTerm/.iterm_profiles)\a"
}
