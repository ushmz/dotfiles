has git || return

if has gh; then
    map gv='gh repo view --web'
    map gcheck='gh pr checkout'
fi

# Worktrees live in <repo root>/.worktrees/<branch>.
# These change the current directory, so they must be shell functions.
function worktree-add() {
    local root
    root=$(git rev-parse --show-toplevel) || return
    git worktree add ${root}/.worktrees/${1} -b ${1} && cd -- ${root}/.worktrees/${1}
}

if has fzf; then
    function worktree() {
        local target=$(git worktree list | awk '{print $1}' | fzf +m)
        [[ -n ${target} ]] && cd -- ${target}
    }

    function worktree-clone() {
        local root branch
        root=$(git rev-parse --show-toplevel) || return
        branch=$(git branch -vv | fzf +m | awk '{print $1}' | sed "s/^\*\s*//g")
        [[ -n ${branch} ]] || return
        git worktree add ${root}/.worktrees/${branch} ${branch} && cd -- ${root}/.worktrees/${branch}
    }
fi

if has ghq && has fzf; then
    # ^g: jump to a ghq repository
    function ghqcd() {
        local destination=$(ghq list -p | fzf +m)
        if [[ -n ${destination} ]]; then
            BUFFER="cd ${destination}"
            zle accept-line
        fi
    }
    zle -N ghqcd
    bindkey '^g' ghqcd
fi
