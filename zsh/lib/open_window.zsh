function open_command() {
  local open_cmd
  local use_nohup=1

  # define the open command
  case "$OSTYPE" in
    darwin*)  open_cmd='open' && use_nohup=0 ;;
    cygwin*)  open_cmd='cygstart' ;;
    linux*)   ! [[ $(uname -a) =~ "[Mm]icrosoft" ]] && open_cmd='xdg-open' || {
                open_cmd='xdg-open' && use_nohup=0
              } ;;
    msys*)    open_cmd='start ""' ;;
    *)        echo "Platform $OSTYPE not supported"
              return 1
              ;;
  esac

  # don't use nohup on OSX or WSL 2
  if [[ use_nohup == 1 ]]; then
    nohup ${=open_cmd} "$@" &>/dev/null
  else
    ${=open_cmd} "$@" &>/dev/null
  fi
}
