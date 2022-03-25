alias ls='ls -lah --color=auto'
alias mv='mv -i'
alias rm='rm -i'

alias update='sudo pacman -Syu'
alias install='sudo pacman -S'
alias remove='sudo pacman -R'
alias autoremove='sudo pacman -Rs $(pacman -Qtdq)'

alias ..='cd ..'
shopt -s autocd
exec {BASH_XTRACEFD}>/dev/null

export EDITOR='vim'
export VISUAL='vim'

export PATH
export HISTCONTROL=ignoreboth

PS1=' \w \$ '
