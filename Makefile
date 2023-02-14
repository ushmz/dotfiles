define _help
	echo "prepare\t: Prepare installation"
	echo "put\t: Put all symbolic links"
	echo "install\t: Install plugins and packages"
	echo "up\t: Do `put` and `install` at once"
	echo "okatazuke": Unlink & remove all synbolic links
	echo "brewfile": Export `Brewfile` with only manually installed formulae and casks
endef

.PHONY: default
default:
	@$(call _help)

.PHONY: prepare
prepare:
	mkdir -p ${HOME}/.config
	mkdir -p ${HOME}/.local/state
	mkdir -p ${HOME}/.local/share
	mkdir -p ${HOME}/.cache

# Put config files
.PHONY: put
put: scripts/put.sh
	sh `pwd`/scripts/put.sh

# Install plugins and packages
.PHONY: install
install: scripts/install.sh
	sh `pwd`/scripts/install.sh

# Put config files and install brew packages (darwin)
.PHONY: up
up: scripts/put.sh scripts/install.sh
	sh `pwd`/scripts/put.sh
	sh `pwd`/scripts/install.sh

.PHONY: okatazuke
okatazuke: scripts/okatazuke.sh
	sh `pwd`/scripts/okatazuke.sh

.PHONY: brewfile
brewfile: scripts/brewfile.sh
	sh `pwd`/scripts/brewfile.sh > Brewfile
