link:
	if [ -L $(HOME)/.zprofile ]; then unlink $(HOME)/.zprofile; fi
	echo "#\!/bin/zsh\nfor i in \$$(command ls $(shell pwd)/zprofile.d/*.zsh | sort)\ndo\n  source \$$i\ndone" > $(HOME)/.zprofile

	if [ -L $(HOME)/.zshrc ]; then unlink $(HOME)/.zshrc; fi
	echo "#\!/bin/zsh\nfor i in \$$(command ls $(shell pwd)/zshrc.d/*.zsh | sort)\ndo\n  source \$$i\ndone" > $(HOME)/.zshrc

	ln -sf `pwd`/.gitmessage $(HOME)/.gitmessage
	ln -sf `pwd`/.gitignore_global $(HOME)/.gitignore_global
	git config --global core.excludesfile $(HOME)/.gitignore_global	
	ln -sf `pwd`/.tmux.conf $(HOME)/.tmux.conf

	mkdir -p "$(HOME)/.vscode/setting.json"
	ln -sf `pwd`/vscode/settings.json $(HOME)/.vscode/setting.json

	mkdir -p "$(XDG_CONFIG_HOME)/nvim/colors"
	mkdir -p "$(XDG_CONFIG_HOME)/nvim/plugins"
	ln -sf `pwd`/.vim/rc/dein.toml $(XDG_CONFIG_HOME)/nvim/dein.toml
	ln -sf `pwd`/.vim/rc/dein_lazy.toml $(XDG_CONFIG_HOME)/nvim/dein_lazy.toml

	ln -sf `pwd`/.config/nvim/coc-settings.json $(XDG_CONFIG_HOME)/nvim/coc-settings.json

	ln -sf `pwd`/.config/nvim/colors/hybrid.vim $(XDG_CONFIG_HOME)/nvim/colors/hybrid.vim

	ln -sf `pwd`/.config/nvim/plugins/coc.rc.vim $(XDG_CONFIG_HOME)/nvim/plugins/coc.rc.vim
	ln -sf `pwd`/.config/nvim/plugins/defx.rc.vim $(XDG_CONFIG_HOME)/nvim/plugins/defx.rc.vim
	ln -sf `pwd`/.config/nvim/plugins/denite.rc.vim $(XDG_CONFIG_HOME)/nvim/plugins/denite.rc.vim
	ln -sf `pwd`/.config/nvim/plugins/silicon.rc.vim $(XDG_CONFIG_HOME)/nvim/plugins/silicon.rc.vim
	ln -sf `pwd`/.config/alacritty/alacritty.yml $(XDG_CONFIG_HOME)/alacritty/alacritty.yml

install:
	`pwd`/scripts/install.sh
