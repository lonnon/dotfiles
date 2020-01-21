# Switch to ZSH shell
if test -t 1; then
    exec zsh
fi

# Check for an interactive session
[ -z "$PS1" ] && return

PS1='[\u@\h \W]\$ '
