#!/bin/sh
set -eu

# Install language servers for nvim build-in lsp
if !( type "npm" > /dev/null 2>&1 ); then
    echo 'npm is not installed. Exit.'
fi

if !( type "pip" > /dev/null 2>&1 ); then
    echo 'npm is not installed. Exit.'
fi

spinner() {
    local pid=$!
    local delay=0.1
    local spinstr='|/-\'
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf " [%c] $1\r" "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
        for ((i=0 ; i<${#1} ; i++)); do
            printf "\b"
        done
    done
    printf " [o] $1\n"
}

brew install lua-language-server 1>/dev/null 2>&1 & spinner "Install lua language server"

npm insall -g typescript typescript-language-server 1>/dev/null 2>&1 & spinner "Install typescript language server"

go install golang.org/x/tools/gopls@latest 1>/dev/null 2>&1 & spinner "Install gopls"

brew install rust-analyzer 1>/dev/null 2>&1 & spinner "Install rust-analyzer"

go install github.com/lighttiger2505/sqls@latest 1>/dev/null 2>&1 & spinner "Install sqls"

pip install pyright 1>/dev/null 2>&1 & spinner "Install python-lsp-server"
