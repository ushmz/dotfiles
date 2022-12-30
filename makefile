define _help
	echo "install\t: Install brew packages"
	echo "put\t: Put all symbolic links"
	echo "up\t: Put all config files and install brew packages (darwin)"
	echo "upl\t: Put all config files and install packages (linux)"
	echo "okatazuke": Unlink & remove all synbolic links
endef

default:
	@$(call _help)

configure:
	mkdir -p $${HOME}/.config
	mkdir -p $${HOME}/.local/state
	mkdir -p $${HOME}/.local/share
	mkdir -p $${HOME}/.cache

# Install brew packages
install: setup/install.darwin.sh
	sh `pwd`/setup/install.darwin.sh

# Put config files
put: setup/put.sh
	sh `pwd`/setup/put.sh

# Put config files and install brew packages (darwin)
up: setup/put.sh setup/install.darwin.sh
	sh `pwd`/setup/put.sh
	sh `pwd`/setup/install.darwin.sh

# Put config files and install plugins (linux)
upl: setup/put.sh setup/install.linux.sh
	sh `pwd`/setup/put.sh
	sh `pwd`/setup/install.linux.sh

okatazuke: setup/okatazuke.sh
	sh `pwd`/setup/okatazuke.sh
