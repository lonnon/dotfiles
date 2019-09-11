export TERM="screen-256color"
export DISPLAY=:0.0

source ~/.zshenv-local
source ~/.zshalias
export PATH="$HOME/.scripts:$HOME/.local/bin:$HOME/.cargo/bin:$PATH:$HOME/.yarn/bin"

export EDITOR="vim"
export MORE="-s"
export PAGER="less"
export MANPAGER="$PAGER"
export VISUAL="$EDITOR"
export HOST="$HOST"

# Declare UTF-8 locale for Ruby 1.9
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"

fpath=($fpath $HOME/.zsh/func)
typeset -U fpath
