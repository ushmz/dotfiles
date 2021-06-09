define _help
	echo 'Apue!!'
	echo "up\t: Put all config files"
	echo "install\t: Install brew packages"
	echo "vim\t: Put .vimrc(For vim, not for nvim)"
endef

default:
	@$(call _help)

# ---------------------
# Install brew packages
# ---------------------
install: ./install.sh 
	sh `pwd`/install.sh

# ---------------------
# Put config files
# ---------------------
up: ./put.sh
	sh `pwd`/put.sh

# ---------------------
# Put config files and install brew packages
# ---------------------
apue: ./install.sh ./install.sh
	sh `pwd`/put.sh
	sh `pwd`/install.sh

# ---------------------
#  Put hyper config file
# ---------------------
hyper: .hyper.js
	ln -sf `pwd`/.hyper.js $(HOME)/.hyper.js

# ---------------------
#  Put .vimrc (for vim, not nvim)
# ---------------------
vim: .vimrc
	ln -sf `pwd`/.vimrc $(HOME)/.vimrc

