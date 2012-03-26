source ~/.zshalias
source ~/.zshdirs

HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.history

setopt autocd
setopt extendedglob
setopt ignoreeof
setopt interactivecomments
setopt autopushd
setopt pushdsilent
setopt pushdtohome
setopt nohup
setopt auto_resume
setopt nobeep
setopt csh_null_glob
setopt promptsubst

# Key bindings.
# Use vi mode, but modify backspace so it still works in insert mode.
bindkey -v
bindkey -M viins '' backward-delete-char
bindkey -M viins '' backward-delete-char
bindkey '[1~' beginning-of-line
bindkey '[4~' end-of-line

# Further modify vi mode so Ctrl+P and Ctrl+N move through history.
bindkey -M viins '' up-history
bindkey -M viins '' down-history

bindkey " " magic-space

bindkey -s '^Z' 'fg\n'
bindkey -s '^W' 'cmd /C start .\n'

bindkey "^o" accept-and-infer-next-history
bindkey "^[#" pound-insert
bindkey "^[/" which-command

autoload -U promptinit
promptinit
prompt lonnon

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
