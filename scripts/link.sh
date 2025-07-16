#!/usr/bin/env sh
set -ue

# Make directory for cdr
mkdir -p "${HOME}/.cache/shell"

# Set environment variables for slack notify
echo "Put slack webhook url for notify (Press Enter to empty)"
read -r url
if [ -n "${url}" ]; then
	echo "export CMD_NOTIFY_SLACK_WEBHOOK_URL='${url}'" >>"${HOME}/.zshenv"
fi

echo "Put slack user name for notify (Press Enter to empty)"
read -r name
if [ -n "${name}" ]; then
	echo "export CMD_NOTIFY_SLACK_USER_NAME='${name}'" >>"${HOME}/.zshenv"
fi

# Remove `~/.zprofile` if exists, and write my `.zprofile`.
if [ -L "${HOME}/.zprofile" ]; then
	unlink "${HOME}/.zprofile"
fi
ln -sf "$(pwd)/zprofile.d/.zprofile" "${HOME}/.zprofile"

# Remove `~/.zshrc` if exists, and write my `.zshrc`.
if [ -L "${HOME}/.zshrc" ]; then
	unlink "${HOME}/.zshrc"
fi
ln -sf "$(pwd)/zshrc.d/.zshrc" "${HOME}/.zshrc"

# .tigrc
mkdir -p "${HOME}/.config/tig/"
ln -sf "$(pwd)/.config/tig/config/.tigrc" "${HOME}/.config/tig/config"

# alacritty config file
mkdir -p "${HOME}/.config/alacritty/"
ln -sf "$(pwd)/.config/alacritty/alacritty.yml" "${HOME}/.config/alacritty/alacritty.yml"

# .tmux.conf
mkdir -p "${HOME}/.config/tmux/"
ln -sf "$(pwd)/.config/tmux/*" "${HOME}/.config/tmux"

# starship.toml
ln -sf "$(pwd)/.config/starship/starship.toml" "${HOME}/.config/starship.toml"

# git config
mkdir -p "${HOME}/.config/git/"
ln -sf "$(pwd)/.config/git/*" "${HOME}/.config/git"
git config --global commit.template "${HOME}/.config/git/message"

# gh config
mkdir -p "${HOME}/.config/gh/"
ln -sf "$(pwd)/.config/gh/config.yml" "${HOME}/.config/gh/config.yml"

# ranger config files
mkdir -p "${HOME}/.config/ranger/"
ln -sf "$(pwd)/.config/ranger/*" "${HOME}/.config/ranger/"

# nvim
mkdir -p "${HOME}/.config/nvim/lua/"
ln -sf "$(pwd)/.config/nvim/lazy-lock.json" "${HOME}/.config/nvim/lazy-lock.json"
ln -sf "$(pwd)/.config/nvim/init.lua" "${HOME}/.config/nvim/init.lua"
ln -sf "$(pwd)/.config/nvim/lua" "${HOME}/.config/nvim/lua"

# cspell
mkdir -p "${HOME}/.config/cspell/"
ln -sf "$(pwd)/.config/cspell/*" "${HOME}/.config/cspell"

# Stop dirtying home directory
echo hsts-file = "${HOME}/.cache/wget-hsts" >"${HOME}/.config/wgetrc"

# less
mkdir -p "${HOME}/.config/less/"
ln -sf "$(pwd)/.config/less/lesskey" "${HOME}/.config/less/lesskey"

mkdir -p "${HOME}/.config/python"
ln -sf "$(pwd)/.config/python/pythonrc.py" "${HOME}/.config/python/pythonrc.py"

# Mac OS specific files
if [ "$(uname)" = "Darwin" ]; then
	# vscode
	ln -sf "$(pwd)/vscode/settings.json" "${HOME}/Library/Application Support/Code/User/settings.json"
	ln -sf "$(pwd)/vscode/keybindings.json" "${HOME}/Library/Application Support/Code/User/keybindings.json"

	# Override for M1 Mac
	if [ "$(uname -m)" = "arm64" ]; then
		ln -sf "$(pwd)/.config/alacritty/alacritty.arm.yml" "${HOME}/.config/alacritty/alacritty.yml"
	fi
fi
