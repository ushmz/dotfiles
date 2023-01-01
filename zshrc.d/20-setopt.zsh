# Omit `cd`
setopt auto_cd
setopt auto_pushd
setopt pushd_silent

# completion

# Auto completing brackets
setopt auto_param_keys

# Completing after `=` in command line arguments
setopt magic_equal_subst

# Force completing in cursor position
setopt complete_in_word

# For 8bit chars
setopt print_eight_bit

# Completing extended glob like `~`, `^` and more...
setopt extended_glob

# `.` insensitive matching
setopt globdots

# zsh history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_no_store
