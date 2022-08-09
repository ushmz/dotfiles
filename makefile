define _help
	echo 'Apue!!'
	echo "up\t: Put all config files(Works on darwin)"
	echo "upl\t: Put all config files(Works on linux)"
	echo "install\t: Install brew packages"
endef

default:
	@$(call _help)

# ---------------------
# Install brew packages
# ---------------------
install: setup/install.darwin.sh
	sh `pwd`/setup/install.darwin.sh

# ---------------------
# Put config files (Works on Darwin)
# ---------------------
up: setup/put.darwin.sh
	sh `pwd`/setup/put.darwin.sh

# ---------------------
# Put config files and install brew packages
# ---------------------
apue: setup/put.darwin.sh setup/install.darwin.sh
	sh `pwd`/setup/put.darwin.sh
	sh `pwd`/setup/install.darwin.sh

# ---------------------
# Put config files (Works on linux)
# ---------------------
upl: setup/put.linux.sh
	sh `pwd`/setup/put.linux.sh

# ---------------------
# Put config files and install plugins
# ---------------------
apuel: setup/put.linux.sh setup/install.linux.sh
	sh `pwd`/setup/put.linux.sh
	sh `pwd`/setup/install.linux.sh
