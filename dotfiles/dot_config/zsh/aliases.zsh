# Helper Function
function alias_if_exists() { command -v $2 > /dev/null && alias $1=$2; }

# SSH
alias s='kitty +kitten ssh'

# Yarn
alias yarn='yarn --use-yarnrc "$XDG_CONFIG_HOME/yarn/config"'

# ls
alias ls='exa'
alias ll='exa -lagh'
alias tree='exa -T --git-ignore'

# cp
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -i'

# clipboard
alias_if_exists pbcopy wl-copy
alias_if_exists pbpaste wl-paste

# Pacman/AUR
alias pins="paru -Slq | fzf -m --preview 'bat --style=numbers --color=always --line-range :500 -l bash <(paru -Si {1}) <(paru -Fl {1} | awk \"{print \$2}\")' | xargs -ro paru -S"
alias pacro='paru -Rns $(pacman -Qtdq)'

# Folders
alias work="$HOME/dirs/proj/work"
alias mine="$HOME/dirs/proj/personal"
