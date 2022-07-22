define _help
	echo 'Apue!!'
	echo "up\t: Put all config files(Works on darwin)"
	echo "upl\t: Put all config files(Works on linux)"
	echo "install\t: Install brew packages"
	echo "vim\t: Put .vimrc(For vim, not for nvim)"
endef

default:
	@$(call _help)

# ---------------------
# Install brew packages
# ---------------------
install: ./install.darwin.sh
	sh `pwd`/install.darwin.sh

# ---------------------
# Put config files (Works on Darwin)
# ---------------------
up: ./put.darwin.sh
	sh `pwd`/put.darwin.sh

# ---------------------
# Put config files and install brew packages
# ---------------------
apue: ./put.darwin.sh ./install.darwin.sh
	sh `pwd`/put.darwin.sh
	sh `pwd`/install.darwin.sh

# ---------------------
# Put config files (Works on linux)
# ---------------------
upl: ./put.linux.sh
	sh `pwd`/put.linux.sh

# ---------------------
# Put config files and install plugins
# ---------------------
apuel: ./put.linux.sh ./install.linux.sh
	sh `pwd`/put.linux.sh
	sh `pwd`/install.linux.sh
