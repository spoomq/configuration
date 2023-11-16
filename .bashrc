alias ls='echo && ls -arh --color=auto'
alias mv='mv -i'
alias rm='rm -i'

alias update='sudo apt update && sudo apt upgrade -y'
alias install='sudo apt install'
alias remove='sudo apt remove'
alias download='sudo dpkg --install'
alias off='sudo apt update && sudo apt upgrade -y && shutdown now'

alias ..='cd ..'
shopt -s autocd
exec {BASH_XTRACEFD}>/dev/null

export EDITOR='vim'
export VISUAL='vim'

export PATH
export HISTCONTROL=ignoreboth

PS1=' \w \$ '
