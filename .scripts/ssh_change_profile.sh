#!/bin/zsh

# Set profile
echo -ne "\033]1337;SetProfile=$@\a"

# ssh login
/usr/bin/ssh "$@"

# Set profile(default)
echo -ne "\033]1337;SetProfile=kahma\a"

