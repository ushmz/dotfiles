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

function branch_gen() {
    git checkout -b feature/$(cat /dev/urandom | head -c 50 | sha256sum | head -c 10)
}
alias gcr="branch_gen"

