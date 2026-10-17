# Resolve the dotfiles root through the ~/.zprofile symlink
export DOTFILES=${${(%):-%x}:A:h:h}

# Files are a linear pipeline (env -> path), so they are numbered
for f in ${DOTFILES}/zprofile.d/*.zsh(N); do
	source $f
done
unset f

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init.zsh 2>/dev/null || :
