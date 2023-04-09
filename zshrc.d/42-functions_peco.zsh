bindkey -e

if type peco &>/dev/null; then
	# Show ps with peco
	function pslist() {
		ps aux | peco | awk '{print $2}'
	}

	# Ctrl-r to search command history
	function peco_select_history() {
		BUFFER=$(\history -n -r 1 | peco --query "$LBUFFER")
		CURSOR=$#BUFFER
		zle reset-prompt
	}
	zle -N peco_select_history
	bindkey '^r' peco_select_history

	# Search distination from cdr list
	function peco_get_destination_from_cdr() {
		cdr -l |
			sed -e 's/^[[:digit:]]*[[:blank:]]*//' |
			peco --query "$LBUFFER"
	}

	# Ctrl-u to search directory from history
	function peco_cdr() {
		local destination="$(peco_get_destination_from_cdr)"
		if [ -n "$destination" ]; then
			BUFFER="cd $destination"
			zle accept-line
		else
			zle reset-prompt
		fi
	}
	zle -N peco_cdr
	bindkey '^u' peco_cdr

	# Ctrl-s to search hostname from .ssh/config
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
	zle -N peco_ssh_host
	bindkey '^s' peco_ssh_host

	if type ghq &>/dev/null; then
		# Ctrl-g to search local repository from ghq root
		function ghq_list() {
			local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
			if [ -n "$selected_dir" ]; then
				BUFFER="cd ${selected_dir}"
				zle accept-line
			fi
			zle clear-screen
		}
		zle -N ghq_list
		bindkey '^g' ghq_list

		# Open repository in `ghq root` with VSCode
		function ghq_code() {
			local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
			if [ -n "$selected_dir" ]; then
				BUFFER="code ${selected_dir}"
				zle accept-line
			fi
			zle clear-screen
		}
		# Ctrl-e to open repository in `ghq root` with VSCode
		# zle -N ghq_code
		# bindkey '^e' ghq_code
	fi

	if type git &>/dev/null; then
		function edas() {
			git checkout $(git branch | peco --prompt "GIT BRANCH>" | head -n 1 | sed -e "s/^\*\s*//g")
		}

		function prune() {
			git branch -d $(git branch | peco --prompt "GIT BRANCH>" | head -n 1 | sed -e "s/^\*\s*//g")
		}
	fi

	function iterm() {
		echo -ne "\033]1337;SetProfile=$(peco ~/dotfiles/iTerm/.iterm_profiles)\a"
	}
fi
