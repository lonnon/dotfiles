# Path to your oh-my-zsh configuration.
ZSH="$HOME/.oh-my-zsh"
ZSH_CUSTOM="$HOME/.zsh/omz_custom"
ZSH_THEME="lonnon"

DISABLE_AUTO_UPDATE="false"
DISABLE_AUTO_TITLE="true"

plugins=(vi-mode open-window)

source "$ZSH/oh-my-zsh.sh"

# Override ugly oh-my-zsh directory listings; I like the default colors.
# EXCEPT for the background highlighting for directories writable by
# others, which is not only hard to read in Solarized, but applies to
# every goddamn directory on a Windows volume mounted under my Arch VM.
# Totally useless as a security measure. See also http://geoff.greer.fm/lscolors/
export LSCOLORS="exfxcxdxbxegedabagexex"
export LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=34:ow=34:"

bindkey "^w" open-current-window
alias o="open-window"

# Turn off abysmal command and argument spellchecking
unsetopt correct_all
unsetopt beep

if [[ "$OSTYPE" == "linux-gnu" ]]; then
  zsh_aws_completer="$HOME/.local/bin/aws_zsh_completer.sh"
elif [[ "$OSTYPE" == "darwin"* ]]; then
  zsh_aws_completer="/Library/Frameworks/Python.framework/Versions/2.7/bin/aws_zsh_completer.sh"
fi
if [ -f $zsh_aws_completer ]; then
  source $zsh_aws_completer
fi

eval $(thefuck --alias)
