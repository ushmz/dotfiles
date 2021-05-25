define _help
	echo 'Apue!!'
	echo "up\t: Put all config files"
	echo "install\t: Install brew packages"
	echo "vim\t: Put .vimrc(For vim, not for nvim)"
endef

default:
	@$(call _help)

install: ./scripts/install.sh 
	# ---------------------
	# Install brew packages
	# ---------------------
	sh `pwd`/scripts/install.sh

up: ./scripts/install.sh
	# ---------------------
	# Put config files
	# ---------------------
	sh `pwd`/scripts/put.sh

apue: ./scripts/install.sh ./scripts/install.sh
	# ---------------------
	# Put config files and install brew packages
	# ---------------------
	sh `pwd`/scripts/put.sh
	sh `pwd`/scripts/install.sh

hyper: .hyper.js
	# ---------------------
	#  Put hyper config file
	# ---------------------
	ln -sf `pwd`/.hyper.js $(HOME)/.hyper.js

vim: .vimrc
	# ---------------------
	#  Put .vimrc (for vim, not nvim)
	# ---------------------
	ln -sf `pwd`/.vimrc $(HOME)/.vimrc

