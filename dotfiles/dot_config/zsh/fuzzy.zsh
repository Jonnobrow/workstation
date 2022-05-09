# Default Command uses fd
export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --ignore-file $XDG_CONFIG_HOME/fd/fd-ignore"

# Ctrl-T uses default command
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Alt-C uses fd
export FZF_ALT_C_COMMAND="fd --type d --hidden --follow --ignore-file $XDG_CONFIG_HOME/fd/fd-ignore"

# Use ~~ as the trigger sequence instead of the default **
export FZF_COMPLETION_TRIGGER='~~'

# Options to fzf command
export FZF_COMPLETION_OPTS='--border --info=inline'

# PReview alias
alias fzfp="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}
