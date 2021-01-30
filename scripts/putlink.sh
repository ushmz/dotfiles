# dotfiles
ln -sf .gitignore_global ~/.gitignore_global
ln -sf .gitmessage ~/.gitmessage
ln -sf .zshrc ~/.zshrc
ln -sf .hyper.js ~/.hyper.js
ln -sf .tmux.conf ~/.tmux.conf

# Configuration files
ln -sf ./vscode/settings.json ~/.vscode/setting.json

source ~/.zshrc
git config --global core.excludesfile ~/.gitignore_global

