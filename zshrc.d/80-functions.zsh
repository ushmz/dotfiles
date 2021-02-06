
# save dirstack to ~/.cache/shell
# mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}/shell"
# touch "${XDG_CACHE_HOME:-$HOME/.cache}/shell/$HOST.dirstack"
# my_save_dirstack () {
#     dirstack=(${(@u)$(<"${XDG_CACHE_HOME:-$HOME/.cache}/shell/$HOST.dirstack")})
#     dirs -lp >! "${XDG_CACHE_HOME:-$HOME/.cache}/shell/$HOST.dirstack"
# }
# chpwd_functions+=my_save_dirstack
# my_save_dirstack

##########################################################
# typo hook
##########################################################
function command_not_found_handler(){
    if [ -e ~/bin/typo.sh ]; then
        ~/bin/typo.sh
    else
        echo "Command $0 not found."
    fi
    return 127
}

function googleit() {
    IFS="+$IFS"
    brave "https://www.google.com/search?q=$*"
    IFS=${IFS#?}
}
alias what="googleit"
