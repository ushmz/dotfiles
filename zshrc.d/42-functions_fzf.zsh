if type fzf &>/dev/null; then
    function fcd() {
        cd $(find . -type d | fzf +m)
    }

    function fcdr() {
		local destination="$(cdr -l | sed -e 's/^[[:digit:]]*[[:blank:]]*//' | fzf +m)"
		if [ -n "${destination}" ]; then
			BUFFER="cd ${destination}"
			zle accept-line
        fi
    }

    function fhist() {
        CURSOR=$(history -n -r 1 | fzf +m)
    }

    function pslist() {
        ps aux | fzf -m --header-lines=1 | awk '{print $2}'
    }

    function pskill() {
        ps aux | fzf -m --header-lines=1 | awk '{print $2}' | xargs kill -9
    }

    function fssh() {
		local res=$(grep "Host " ~/.ssh/config | grep -v '*' | cut -b 6- | fzf +m)
		if [ -n "${res}" ]; then
			BUFFER="ssh ${res}"
			CURSOR=$#BUFFER
			zle clear-screen
        fi
    }

    if type ghq &>/dev/null; then
        function ghqcd() {
            BUFFER="cd $(ghq list -p | fzf +m)"
            zle accept-line
        }
        zle -N ghqcd
        bindkey '^g' ghqcd

        function ghq-code() {
            ghq list -p | fzf +m | xargs -I % code %
        }

        function ghqcd-kill() {
            ghq list -p | fzf -m | xargs -I -P2 % sh -c 'rm -rf %'
        }
    fi

	if type git &>/dev/null; then
        function fbr() {
            git checkout $(git branch -vv | fzf +m | awk '{print $1}' | sed "s/^\*\s*//g")
        }

        function fbrd() {
            git branch -vv | fzf -m | awk '{print $1}' | sed "s/^\*\s*//g" | xargs git branch -d
        }

        function fbrdd() {
            git branch -vv | fzf -m | awk '{print $1}' | sed "s/^\*\s*//g" | xargs git branch -D
        }

        function fshow() {
            git log --graph --color=always \
                --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
            fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
                --bind "ctrl-m:execute:
                            (grep -o '[a-f0-9]\{7\}' | head -1 |
                            xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                            {}
            FZF-EOF"
        }

        function fwt() {
            cd $(git worktree list | awk '{print $1}' | fzf +m)
        }

        function fwt-rm() {
            git worktree list | awk '{ print $1}' | fzf -m | xargs -I % git worktree remove -f %
        }
	fi
fi
