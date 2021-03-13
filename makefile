link:
	if [ -L $(HOME)/.zprofile ]; then unlink $(HOME)/.zprofile; fi
	echo "#\!/bin/zsh\nfor i in \$$(command ls $(shell pwd)/zprofile.d/*.zsh | sort)\ndo\n  source \$$i\ndone" > $(HOME)/.zprofile

	if [ -L $(HOME)/.zshrc ]; then unlink $(HOME)/.zshrc; fi
	echo "#\!/bin/zsh\nfor i in \$$(command ls $(shell pwd)/zshrc.d/*.zsh | sort)\ndo\n  source \$$i\ndone" > $(HOME)/.zshrc

	ln -sf `pwd`/.gitignore_global $(HOME)/.gitignore_global
	ln -sf `pwd`/.gitmessage $(HOME)/.gitmessage
	ln -sf `pwd`/.hyper.js $(HOME)/.hyper.js
	ln -sf `pwd`/.tmux.conf $(HOME)/.tmux.conf

	mkdir -p "$(HOME)/.vscode/setting.json"
	ln -sf `pwd`/vscode/settings.json $(HOME)/.vscode/setting.json
	git config --global core.excludesfile $(HOME)/.gitignore_global	

	mkdir -p "$(HOME)/.config/nvim/colors"
	mkdir -p "$(HOME)/.config/nvim/plugins"
	ln -sf `pwd`/.vim/rc/dein.toml $(HOME)/.config/nvim/dein.toml
	ln -sf `pwd`/.vim/rc/dein_lazy.toml $(HOME)/.config/nvim/dein_lazy.toml

	ln -sf `pwd`/.config/nvim/coc-settings.json $(HOME)/.config/nvim/coc-settings.json

	ln -sf `pwd`/.config/nvim/colors/hybrid.vim $(HOME)/.config/nvim/colors/hybrid.vim

	ln -sf `pwd`/.config/nvim/plugins/coc.rc.vim $(HOME)/.config/nvim/plugins/coc.rc.vim
	ln -sf `pwd`/.config/nvim/plugins/defx.rc.vim $(HOME)/.config/nvim/plugins/defx.rc.vim
	ln -sf `pwd`/.config/nvim/plugins/denite.rc.vim $(HOME)/.config/nvim/plugins/denite.rc.vim

install:
	`pwd`/scripts/install.sh
