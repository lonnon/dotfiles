autoload -U replace-string
zle -N replace-regex replace-string
bindkey -a 'q' replace-regex

bindkey -v '^p' up-line-or-search
bindkey -v '^n' down-line-or-search

autoload -U promptinit; promptinit
prompt pure

# Load libraries
ZSH_LIB="$HOME/.zsh/lib"
for config_file ($ZSH_LIB/*.zsh); do
  source $config_file
done

# TODO: make this a widget again
# bindkey "^w" "open_command ."
alias o="open_command ."

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

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

eval $(thefuck --alias)

export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).
