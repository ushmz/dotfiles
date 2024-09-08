local function map() {
    if type abbr &>/dev/null; then
        abbr -g -S -q --force "$@" &>/dev/null
    else
        alias "$@"
    fi
}

# Google it func
function googleit() {
    IFS="+$IFS"
    open "https://www.google.com/search?q=$*&gl=us&hl=en" 1>/dev/null 2>&1
    IFS=${IFS#?}
}

function guguru() {
    IFS="+$IFS"
    open "https://www.google.com/search?q=$*&gl=ja&hl=ja" 1>/dev/null 2>&1
    IFS=${IFS#?}
}

alias what="googleit"
alias ggr="googleit"

alias jwhat="guguru"
alias jggr="guguru"

# Source python venv if exists
function sourse_pyenv() {
    if [[ -n ${1} ]]; then
        # shellcheck source=/dev/null
        source ./${1}/bin/activate
    elif [[ -d './.venv' ]]; then
        # shellcheck source=/dev/null
        source ./.venv/bin/activate
    elif [[ -d './venv' ]]; then
        # shellcheck source=/dev/null
        source ./venv/bin/activate
    else
        echo 'Connot find pyenv environment.'
    fi
}
map venv='sourse_pyenv'

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

function review() {
    gh pr checkout "$1" && nvim -c "lua vim.g.review = "$1""
}
