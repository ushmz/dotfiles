define _help
	echo 'up'		"\t""\t" ': Do dotfile setup at once'
	echo 'unlink'	"\t""\t" ': Unlink & remove all synbolic links'
	echo ""
	echo 'init'		"\t""\t" ': Prepare for installation'
	echo 'link'		"\t""\t" ': Put all symbolic links'
	echo 'defaults'		"\t" ': Configure for Darwin'
	echo 'install'		"\t" ': Install plugins and packages'
	echo ""
	echo 'brewfile'		"\t" ': Export `Brewfile` with only manually installed formulae and casks'
	echo 'check'		"\t" ': Check shell config syntax and zshrc.d rules'
endef

.PHONY: default
default:
	@$(call _help)

# Put config files and install brew packages (darwin)
.PHONY: up
up: init link defaults install

.PHONY: unlink
unlink: scripts/unlink.sh
	sh `pwd`/scripts/unlink.sh

.PHONY: init
init: scripts/init.sh
	sh `pwd`/scripts/init.sh

# Put config files
.PHONY: link
link: scripts/link.sh
	sh `pwd`/scripts/link.sh

.PHONY: defaults
defaults: scripts/defaults.sh
	sh `pwd`/scripts/defaults.sh

# Install plugins and packages
.PHONY: install
install: scripts/install.sh
	sh `pwd`/scripts/install.sh

.PHONY: brewfile
brewfile: scripts/brewfile.sh
	sh `pwd`/scripts/brewfile.sh > Brewfile

# Syntax check, and conf.d must not run compinit/compdef (see zshrc.d/README.md)
.PHONY: check
check:
	@for f in zprofile.d/.zprofile zprofile.d/*.zsh zshrc.d/.zshrc zshrc.d/*.zsh zshrc.d/conf.d/*.zsh; do zsh -n "$$f" || exit 1; done
	@for f in bin/*; do bash -n "$$f" || exit 1; done
	@! grep -nE '^[[:space:]]*(compinit|compdef)([[:space:]]|$$)' zshrc.d/conf.d/*.zsh
