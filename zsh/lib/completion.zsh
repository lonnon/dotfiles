# zstyle ':completion:*' 'matcher-list' '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}'
zstyle ':completion:*' max-errors 2 numeric
zstyle ':completion:*' menu select=long
zstyle :compinstall filename "$HOME/.zsh/lib/completion.zsh"

autoload -Uz compinit
compinit
# End of lines added by compinstall
