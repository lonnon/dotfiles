# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="lonnon"
ZSH_THEME="powerlevel9k/powerlevel9k"
POWERLEVEL9K_MODE='awesome-patched'
POWERLEVEL9K_HOME_ICON=''
POWERLEVEL9K_HOME_SUB_ICON=''
POWERLEVEL9K_FOLDER_ICON=''

POWERLEVEL9K_VCS_GIT_ICON=''
POWERLEVEL9K_VCS_INCOMING_CHANGES_ICON='\UE1EB ' # 
POWERLEVEL9K_VCS_OUTGOING_CHANGES_ICON='\UE1EC ' # 

POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="\n"
POWERLEVEL9K_MULTILINE_SECOND_PROMPT_PREFIX="%K{white}%F{black} `date +%T` %f%k%F{white}%f  "

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon context dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status background_jobs history vi_mode)

POWERLEVEL9K_VI_MODE_NORMAL_BACKGROUND='white'
POWERLEVEL9K_VI_MODE_NORMAL_FOREGROUND='blue'
POWERLEVEL9K_VI_MODE_INSERT_BACKGROUND='white'
POWERLEVEL9K_VI_MODE_INSERT_FOREGROUND='black'
POWERLEVEL9K_VI_INSERT_MODE_STRING='\UE154' # 
POWERLEVEL9K_VI_COMMAND_MODE_STRING='\UE1E5' # 

POWERLEVEL9K_OS_ICON_BACKGROUND='white'
POWERLEVEL9K_OS_ICON_FOREGROUND='black'

POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
POWERLEVEL9K_SHORTEN_STRATEGY=''
POWERLEVEL9K_SHORTEN_DELIMITER='…'

POWERLEVEL9K_STATUS_VERBOSE=false
POWERLEVEL9K_STATUS_ERROR_BACKGROUND='red'
POWERLEVEL9K_STATUS_ERROR_FOREGROUND='black'
POWERLEVEL9K_FAIL_ICON='\UE125' # 

POWERLEVEL9K_SHOW_CHANGESET=true
POWERLEVEL9K_CHANGESET_HASH_LENGTH=6


DEFAULT_USER=lonnonfoster

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git vi-mode open-window)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

# Override ugly oh-my-zsh directory listings; I like the default colors.
# EXCEPT for the background highlighting for directories writable by
# others, which is not only hard to read in Solarized, but applies to
# every goddamn directory on a Windows volume mounted under my Arch VM.
# Totally useless as a security measure. See also http://geoff.greer.fm/lscolors/
export LSCOLORS="exfxcxdxbxegedabagexex"
export LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=34:ow=34:"

bindkey '^w' open-current-window
alias o=open-window

# Turn off abysmal command and argument spellchecking
unsetopt correct_all

# Remove useless space at end of rprompt
ZLE_RPROMPT_INDENT=0

zsh_aws_completer='/Library/Frameworks/Python.framework/Versions/2.7/bin/aws_zsh_completer.sh'
if [ -f $zsh_aws_completer ]; then
  source $zsh_aws_completer
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
