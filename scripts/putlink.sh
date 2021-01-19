ln -sf ./dotfiles/gitignore_global ~/.gitignore_global
ln -sf ./dotfiles/gitmessage ~/.gitmessage
ln -sf ./dotfiles/zshrc ~/.zshrc
ln -sf ./dotfiles/.hyper.js ~/.hyper.js
ln -sf ./dotfiles/vscode/settings.json ~/.vscode/setting.json

source ~/.zshrc
git config --global core.excludesfile ~/.gitignore_global

