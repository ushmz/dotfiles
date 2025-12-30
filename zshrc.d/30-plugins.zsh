# zsh-autopair
# | Works wonderfully with [zsh-syntax-highlight] and ZSH_HIGHLIGHT_HIGHLIGHTERS+=brackets,
# | but zsh-syntax-highlight must be loaded after zsh-autopair.
if [ -d "${XDG_CACHE_HOME}/zsh-autopair" ]; then
    # shellcheck source=/dev/null
    source "${XDG_CACHE_HOME}/zsh-autopair/autopair.zsh"
    autopair-init
fi

# zsh highlighting & auto suggestion plugins
# zsh-syntax-highlighting
if [ -d "${XDG_CACHE_HOME}/zsh-syntax-highlighting/" ]; then
    ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets cursor)
    # shellcheck source=/dev/null
    source "${XDG_CACHE_HOME}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# zsh-autosuggestions
if [ -d "${XDG_CACHE_HOME}/zsh-autosuggestions" ]; then
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=245'
    # shellcheck source=/dev/null
    source "${XDG_CACHE_HOME}/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

# zsh completions for linux
if [ -d "${XDG_CACHE_HOME}/zsh-completions" ]; then
    FPATH="${XDG_CACHE_HOME}/zsh-completions/src:$FPATH"
fi

# direnv
if type direnv &>/dev/null; then
	eval "$(direnv hook zsh)"
fi

# asdf (Language version manager)
if type asdf &>/dev/null; then
	# shellcheck source=/dev/null
	source $(brew --prefix asdf)/libexec/asdf.sh
fi
