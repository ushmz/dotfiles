#! /bin/zsh

##########################################################
# Install brew
##########################################################
echo "install brew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

echo "brew updating..."
brew update
brew cleanup
brew upgrade
brew cask upgrade

##########################################################
# Replace Mac commands with GNU/Linux commands
##########################################################
brew install coreutils
brew install diffutils
brew install ed
brew install findutils
brew install gawk
brew install gnu-sed
brew install gnu-tar
brew install grep
brew install gzip

##########################################################
# Linux commands rewrite by Rust
##########################################################
brew install bat
brew install exa
brew install hexyl
brew install fd
brew install ripgrep
brew install procs
brew tap cjbassi/ytop
brew install ytop

##########################################################
# Useful Commands?
##########################################################
brew install ag
brew install gitmoji
gem install colorls
brew install jq
brew install lv
brew install navi
brew install parallel
brew install pandoc
brew install q
brew install sift
brew install sl
brew install starship
brew install tmux
brew install wget
brew install wdiff --with-gettext
brew install xmlstarlet

##########################################################
# zsh plugin
##########################################################
brew install zsh-syntax-highlighting
echo 'source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' >> ~/.zshrc
brew install zsh-autosuggestions
echo 'source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh' >> ~/.zshrc
brew install zsh-completions
chmod 0755 /usr/local/share/zsh/site-functions
chmod 0755 /usr/local/share
chmod 0755 /usr/local/share/zsh

##########################################################
# install developing tools
##########################################################
brew install ansible
# brew install awscli
# brew install aws-iam-authenticator
brew install bazel
brew install cocoapods
brew install docker-compose
brew install gcc
brew install gibo
brew install git
brew tap heroku/brew
brew install heroku
# brew install kubesec
# brew install kubernetes-cli
brew install make
brew install mecab
brew install mecab-ipadic
brew install mysql
brew install openssh
brew install openssl 
brew install peco
brew install postgresql
brew install redis
brew install sqlite
brew install tree
brew install unrar
brew install watch
brew install xz
# brew install filosottile/musl-cross/musl-cross

##########################################################
# install programming languages
##########################################################
# dart lang
brew tap dart-lang/dart
brew install dart

# js / node,js
brew install nodebrew
brew install deno

# python
brew install python3
brew install pyenv
# poetry
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python

# java
brew cask install java
brew install jenv
brew tap AdoptOpenJDK/openjdk
# Require Password
brew cask install adoptopenjdk8
brew cask install adoptopenjdk11
brew cask install adoptopenjdk14

# haskell(stack)
brew install stack
stack setup

# others
brew install go
brew install kotlin
brew install php

##########################################################
# install mac desktop apps
##########################################################
brew cask install alfred
brew cask install adobe-creative-cloud
brew cask install cheatsheet
brew cask install coteditor
brew cask install discord
brew cask install docker
brew cask install font-hack-nerd-font
brew cask install gitkraken
brew cask install google-japanese-ime
brew cask install hyper
brew cask install inkdrop
brew cask install iterm2
brew cask install mendeley
brew cask install microsoft-teams
brew cask install postman
brew cask install rectangle
brew cask install slack
brew cask install tableplus
brew cask install typora
brew cask install visual-studio-code
brew cask install zoomus

##########################################################
# Clean up
##########################################################
brew cleanup
