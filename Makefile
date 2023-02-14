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
put: scripts/put.sh
    sh `pwd`/scripts/put.sh

# Install plugins and packages
install: scripts/install.sh
    sh `pwd`/scripts/install.sh

# Put config files and install brew packages (darwin)
up: scripts/put.sh scripts/install.sh
    sh `pwd`/scripts/put.sh
    sh `pwd`/scripts/install.sh

okatazuke: scripts/okatazuke.sh
    sh `pwd`/scripts/okatazuke.sh

brewfile: scripts/brewfile.sh
    sh `pwd`/scripts/brewfile.sh > Brewfile
