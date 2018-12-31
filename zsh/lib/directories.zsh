setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

alias -- -='cd -'
alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'

alias md='mkdir -p'
alias rd=rmdir
alias d='dirs -v | head -10'
alias purge='rm *~ .*~ *.*~ \#*'
alias rmtmp='rm **/*~'

alias ls='ls -hFG'
alias la='ls -A'
alias ll='ls -l'
alias lla='ls -Al'
alias l.='ls -d .*'
alias ll.='ls -ld .*'
