#!/bin/zsh

ZSH_THEME_BARE_GIT_PROMPT_SHA_BEFORE=" ("
ZSH_THEME_BARE_GIT_PROMPT_SHA_AFTER=":"

ZSH_THEME_BARE_GIT_PROMPT_PREFIX=""
ZSH_THEME_BARE_GIT_PROMPT_SUFFIX=")"
ZSH_THEME_BARE_GIT_PROMPT_DIRTY=" *"
ZSH_THEME_BARE_GIT_PROMPT_CLEAN=""

bare_git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "$ZSH_THEME_BARE_GIT_PROMPT_PREFIX${ref#refs/heads/}$(bare_parse_git_dirty)$ZSH_THEME_BARE_GIT_PROMPT_SUFFIX"
}

bare_parse_git_dirty() {
  local SUBMODULE_SYNTAX=''
  if [[ $POST_1_7_2_GIT -gt 0 ]]; then
        SUBMODULE_SYNTAX="--ignore-submodules=dirty"
  fi
  if [[ -n $(git status -s ${SUBMODULE_SYNTAX}  2> /dev/null) ]]; then
    echo "$ZSH_THEME_BARE_GIT_PROMPT_DIRTY"
  else
    echo "$ZSH_THEME_BARE_GIT_PROMPT_CLEAN"
  fi
}

bare_git_prompt_short_sha() {
  SHA=$(git rev-parse --short HEAD 2> /dev/null) && echo "$ZSH_THEME_BARE_GIT_PROMPT_SHA_BEFORE$SHA$ZSH_THEME_BARE_GIT_PROMPT_SHA_AFTER"
}

_lonnon_precmd() {
  # Determine terminal width so path never exceeds current width of terminal.
  local TERMWIDTH
  (( TERMWIDTH = ${COLUMNS} - 1 ))
  BARE_PROMPT=${(%):-%n@%m $(bare_git_prompt_short_sha)$(bare_git_prompt_info)}
  local PROMPTSIZE=${#BARE_PROMPT}
  local PWDSIZE=${#${(%):-%~}}

  if [[ "$PROMPTSIZE + $PWDSIZE" -gt $TERMWIDTH ]]; then
    (( PR_PWDLEN = $TERMWIDTH - $PROMPTSIZE ))
  fi

}
precmd_functions+=_lonnon_precmd


ZSH_THEME_GIT_PROMPT_SHA_BEFORE=" %{$fg[default]%}(%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SHA_AFTER="%{$fg[default]%}:"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[default]%})%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}⚑"
ZSH_THEME_GIT_PROMPT_CLEAN=""

MODE_INDICATOR="%{$fg_bold[red]%}-cmd-%{$reset_color%}"

PROMPT='
'
PROMPT+='%{$bg[black]$fg[green]%}%n%{$fg[blue]%}@%{$fg[green]%}%m '
### PROMPT+='%{$fg[yellow]%}%~'
PROMPT+='%{$fg[yellow]%}%${PR_PWDLEN}<…<%~%<<'
PROMPT+='$(git_prompt_short_sha)'
PROMPT+='$(git_prompt_info)'
PROMPT+='%{$reset_color%}'
PROMPT+='
'
# PROMPT+='%{$fg[cyan]%}%#%{$reset_color%} '
PROMPT+='%{$fg[cyan]%}ﰌ%{$reset_color%} '

RPROMPT='$(vi_mode_prompt_info) !%{$fg[cyan]%}%!%{$reset_color%}'
