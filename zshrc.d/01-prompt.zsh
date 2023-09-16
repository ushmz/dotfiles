bindkey -e

get_cwd() {
    local branch
    branch=$(git symbolic-ref --short HEAD 2>/dev/null)
    if [[ -n $branch ]]; then
        echo "%B%F{blue}%C%f%b on %B%F{magenta} ${branch}%f%b"
    else
        echo "%B%F{blue}%~%f%b"
    fi
}

get_prompt() {
    local propmt
    if [[ $? -eq 0 ]]; then
        echo "%F{blue}❯%f%F{yellow}❯%f%F{white}❯ %f";
    else
        echo "%F{red}❯❯❯ %f";
    fi
}

precmd_refresh_prompt() {
    export PS1=$'\n'"$(get_cwd)"$'\n'"$(get_prompt)"
}

setopt prompt_subst
autoload -Uz add-zsh-hook
add-zsh-hook precmd precmd_refresh_prompt
