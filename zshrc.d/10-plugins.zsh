# zsh-autopair
# | Works wonderfully with [zsh-syntax-highlight] and ZSH_HIGHLIGHT_HIGHLIGHTERS+=brackets,
# | but zsh-syntax-highlight must be loaded after zsh-autopair.
# git clone https://github.com/hlissner/zsh-autopair ${XDG_CACHE_HOME}/zsh-autopair
if [ -d ${XDG_CACHE_HOME}/zsh-autopair ]; then
	# shellcheck source=/dev/null
	source ${XDG_CACHE_HOME}/zsh-autopair/autopair.zsh
	autopair-init
fi

# zsh highlighting & auto suggestion plugins
# zsh-syntax-highlighting
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${XDG_CACHE_HOME}/zsh-syntax-highlighting
if [ -d ${XDG_CACHE_HOME}/zsh-syntax-highlighting/ ]; then
	# shellcheck source=/dev/null
	source ${XDG_CACHE_HOME}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# zsh-autosuggestions
# git clone https://github.com/zsh-users/zsh-autosuggestions ${XDG_CACHE_HOME}/zsh-autosuggestions
if [ -d ${XDG_CACHE_HOME}/zsh-autosuggestions ]; then
	# shellcheck source=/dev/null
	source ${XDG_CACHE_HOME}/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# zsh completions for linux
# git clone https://github.com/zsh-users/zsh-completions.git ${XDG_CACHE_HOME}/zsh-completions
if [ -d ${XDG_CACHE_HOME}/zsh-completions ]; then
	FPATH=${XDG_CACHE_HOME}/zsh-completions/src:$FPATH
fi

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets cursor)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=245'
