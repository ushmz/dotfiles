link:
	if [ -L $(HOME)/.zprofile ]; then unlink $(HOME)/.zprofile; fi
	echo "#\!/bin/zsh\nfor i in \$$(command ls $(shell pwd)/zprofile.d/*.zsh | sort)\ndo\n  source \$$i\ndone" > $(HOME)/.zprofile

	if [ -L $(HOME)/.zshrc ]; then unlink $(HOME)/.zshrc; fi
	echo "#\!/bin/zsh\nfor i in \$$(command ls $(shell pwd)/zshrc.d/*.zsh | sort)\ndo\n  source \$$i\ndone" > $(HOME)/.zshrc

	ln -sf `pwd`/.gitignore_global $(HOME)/.gitignore_global
	ln -sf `pwd`/.gitmessage $(HOME)/.gitmessage
	ln -sf `pwd`/.hyper.js $(HOME)/.hyper.js
	ln -sf `pwd`/.tmux.conf $(HOME)/.tmux.conf

	ln -sf `pwd`/vscode/settings.json $(HOME)/.vscode/setting.json
	git config --global core.excludesfile $(HOME)/.gitignore_global	

install:
	`pwd`/scripts/install.sh
