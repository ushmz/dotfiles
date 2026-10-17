# Resolve zshrc.d through the ~/.zshrc symlink
ZSHRC_D=${${(%):-%x}:A:h}

# core     : helpers shared by every file (no configuration)
# conf.d/* : one file per topic. MUST NOT depend on each other or on load order
# finalize : the only place where order matters (compinit, zle plugins)
# local    : machine-local overrides (gitignored)
source ${ZSHRC_D}/core.zsh
for f in ${ZSHRC_D}/conf.d/*.zsh(N); do
	source $f
done
unset f
source ${ZSHRC_D}/finalize.zsh
[[ -r ${ZSHRC_D}/local.zsh ]] && source ${ZSHRC_D}/local.zsh
