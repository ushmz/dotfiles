#! /bin/sh

##########################################################
# Install brew
##########################################################
if ! brew; then
    echo "--- install brew ---"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

echo "--- updating brew ---"
brew update
brew cleanup
brew upgrade
brew cask upgrade

##########################################################
# zsh plugin
##########################################################
echo "--- install zsh plugins ---"
brew install zsh-syntax-highlighting
brew install zsh-autosuggestions
brew install zsh-completions
chmod 0755 /usr/local/share
chmod 0755 /usr/local/share/zsh
chmod 0755 /usr/local/share/zsh/site-functions


##########################################################
# brew formulae
##########################################################
echo "--- install formulae ---"
formulae=(
    # Replace Mac commands with GNU/Linux commands
    coreutils
    diffutils
    findutils
    gnu-sed
    gnu-tar
    grep
    gzip

    # Linux alternative commands rewrite by Rust
    bat        # A `cat` clone with wings.
    exa        # A modern replacement for `ls`.
    hexyl      # A command-line hex viewer.
    fd         # A simple alternative to `find`.
    ripgrep    # A line-oriented search tool.
    procs      # A modern replacement for `ps`.

    # Useful Commands
    ag
    jq
    navi
    q
    # sift
    sl
    starship
    tmux
    wget

    # install developing tools
    ansible
    # awscli
    # aws-iam-authenticator
    # bazel
    cocoapods
    docker-compose
    gcc
    gibo
    git
    heroku
    # kubesec
    # kubernetes-cli
    make
    mysql
    openssh
    openssl
    peco
    postgresql
    redis
    sqlite
    tig
    tree
    unrar
    watch
    xz
    # filosottile/musl-cross/musl-cross
)
for formula in $formulae
do
    brew install $formula
done

##########################################################
# install programming languages
##########################################################
echo "--- install languages (NEED PASSWORD) ---"

brew install go
brew install kotlin
brew install php
brew install deno

# haskell(stack)
brew install stack
stack setup

# dart lang
brew tap dart-lang/dart
brew install dart

# poetry
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python

# asdf
brew install asdf

# install languages by asdf (PATH configuration is in `.zprofile`)
asdf install nodejs 14.18.3
asdf install nodejs 16.13.2
asdf install python 3.10.0

##########################################################
# install mac desktop apps
##########################################################
echo "--- install casks ---"
casks=(
    alacritty
    alfred
    cheatsheet
    coteditor
    discord
    docker
    font-hack-nerd-font
    google-japanese-ime
    iterm2
    microsoft-teams
    notion
    postman
    rectangle
    slack
    tableplus
    visual-studio-code
    zoomus
)
for cask in $casks
do
    brew cask install $cask
done

##########################################################
# Clean up
##########################################################
brew cleanup
