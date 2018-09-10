export TERM='screen-256color'

source ~/.zshenv-local
source ~/.zshalias
export PATH=$HOME/.scripts:$PATH

export EDITOR=vim
export MORE='-s'
export PAGER='less'
export MANPAGER="$PAGER"
export VISUAL="$EDITOR"
# export RUBYOPT=rubygems

# Declare UTF-8 locale for Ruby 1.9
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export PATH=$PATH:$HOME/.oh-my-zsh/custom/plugins/fzf/bin
fpath=($fpath $HOME/.zsh/func)
typeset -U fpath

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
source $HOME/.rvm/scripts/rvm
