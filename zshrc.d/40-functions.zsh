# save dirstack to ~/.cache/shell
# mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}/shell"
# touch "${XDG_CACHE_HOME:-$HOME/.cache}/shell/$HOST.dirstack"
# my_save_dirstack () {
#     dirstack=(${(@u)$(<"${XDG_CACHE_HOME:-$HOME/.cache}/shell/$HOST.dirstack")})
#     dirs -lp >! "${XDG_CACHE_HOME:-$HOME/.cache}/shell/$HOST.dirstack"
# }
# chpwd_functions+=my_save_dirstack
# my_save_dirstack

# typo hook
# function command_not_found_handler(){
#     # if [ -e ~/.scripts/typo.sh ]; then
#     #     ~/.scripts/typo.sh
#     if type cowsay &>/dev/null; then
#         cowsay " Command '$0' not found. "
#     else
#         echo "Command $0 not found."
#     fi
#     return 127
# }

# Google it func
function googleit() {
    IFS="+$IFS"
    brave "https://www.google.com/search?q=$*&gl=us&hl=en" 1>/dev/null 2>&1
    IFS=${IFS#?}
}

function guguru() {
    IFS="+$IFS"
    brave "https://www.google.com/search?q=$*&gl=ja&hl=ja" 1>/dev/null 2>&1
    IFS=${IFS#?}
}

alias what="googleit"
alias ggr="googleit"

alias jwhat="guguru"
alias jggr="guguru"

# Change iTerm profile
function itermprof() { echo -ne "\033]1337;SetProfile=$@\a" }

# Source python venv if exists
function sourse_pyenv() {
    if [[ -n $1 ]]; then
        source ./$1/bin/activate
    elif [[ -d './.venv' ]]; then
        source ./.venv/bin/activate
    elif [[ -d './venv' ]]; then
        source ./venv/bin/activate
    else
        echo 'Connot find pyenv environment.'
    fi
}
alias venv='sourse_pyenv'

# Convert movie file to gif.
# $1 : Input file name
# $2 : Output file name
function mov2gif() {
    ffmpeg -i $1 -filter_complex "[0:v] fps=10,split [a][b];[a] palettegen [p];[b][p] paletteuse=dither=none" $2
}

function ghcr() {
    gh repo create $argv
    ghq get git@github.com:ushmz/{$argv[1]}.git
}

function zshaddhistory() {
    local line="${1%%$'\n'}"
    [[ ! "$line" =~ "^(cd|jj?|lazygit|la|ll|ls|rm|rmdir)($| )" ]]
}
