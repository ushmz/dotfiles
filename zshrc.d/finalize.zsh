# Order-sensitive setup. Runs after every conf.d/*.zsh, top to bottom.

# fpath is complete at this point
autoload -Uz compinit && compinit -d ${XDG_STATE_HOME}/.zcompdump

# zsh-autopair
# | Works wonderfully with [zsh-syntax-highlight] and ZSH_HIGHLIGHT_HIGHLIGHTERS+=brackets,
# | but zsh-syntax-highlight must be loaded after zsh-autopair.
if [[ -r ${XDG_CACHE_HOME}/zsh-autopair/autopair.zsh ]]; then
    source ${XDG_CACHE_HOME}/zsh-autopair/autopair.zsh
    autopair-init
    # autopair-init takes over the space key; give it back to zsh-abbr
    (( $+widgets[abbr-expand-and-insert] )) && bindkey ' ' abbr-expand-and-insert
fi

# zsh-syntax-highlighting wraps existing zle widgets, so it comes after all of them
if [[ -r ${XDG_CACHE_HOME}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
    ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets cursor)
    source ${XDG_CACHE_HOME}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# zsh-autosuggestions
if [[ -r ${XDG_CACHE_HOME}/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=245'
    source ${XDG_CACHE_HOME}/zsh-autosuggestions/zsh-autosuggestions.zsh
fi
