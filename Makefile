define _help
	echo "prepare\t: Prepare installation"
	echo "put\t: Put all symbolic links"
	echo "install\t: Install plugins and packages"
	echo "up\t: Do `put` and `install` at once"
	echo "okatazuke": Unlink & remove all synbolic links
	echo "brewfile": Export `Brewfile` with only manually installed formulae and casks
endef

default:
	@$(call _help)

prepare:
	mkdir -p $${HOME}/.config
	mkdir -p $${HOME}/.local/state
	mkdir -p $${HOME}/.local/share
	mkdir -p $${HOME}/.cache

# Put config files
put: setup/put.sh
	sh `pwd`/setup/put.sh

# Install plugins and packages
install: setup/install.sh
	sh `pwd`/setup/install.sh

# Put config files and install brew packages (darwin)
up: setup/put.sh setup/install.sh
	sh `pwd`/setup/put.sh
	sh `pwd`/setup/install.sh

okatazuke: setup/okatazuke.sh
	- sh `pwd`/setup/okatazuke.sh

brewfile: setup/brewfile.sh
	- sh `pwd`/setup/brewfile.sh > Brewfile
