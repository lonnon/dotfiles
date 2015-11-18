# Check for an interactive session
[ -z "$PS1" ] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
