# A little helper for man/alias/function info
function halp() {
  local YELLOW = "\033[0;33m"
  local DEFAULT = "\033[0;39m"
  local apro = 0
  local helpstring = "Usage: halp COMMAND"

  OPTIND=1
  while getopts "kh" opt; do
    case $opt in
      k) apro=1 ;;
      h) echo -e $helpstring; return;;
      *) return 1;;
    esac
  done
  shift $((OPTIND-1))

  if [ $# -ne 1 ]; then
    echo -e $helpstring
    return 1
  fi

  local helpresult cmd=$1
  local cmdtest=$(whence -w ${cmd})

  if [ -z "$cmdtest" ]; then
    echo -e "${YELLOW}Not a command$DEFAULT"
    if [[ $apro == 1 ]]; then
      man -k $cmd
    else
      return 1
    fi
  fi

  if [[ $cmdtest == "${cmd}: command" ]]; then
    echo -ne "$YELLOW$cmd is a symlink: $DEFAULT"
    whence -pS $cmd

  elif [[ $cmdtest == "${cmd}: alias" ]]; then
    echo -ne "$YELLOW$cmd is an alias: $DEFAULT"
    alias ${cmd} | sed -E "s/alias $cmd='(.*)'/\1/"

  elif [[ $cmdtest == "${cmd}: function" ]]; then
    echo -ne "$YELLOW"
    type ${cmd}
    echo -ne "$DEFAULT"

  elif [[ $cmdtest == "${cmd}: builtin" ]]; then
    echo -ne "$YELLOW"
    type ${cmd}
    echo -ne "$DEFAULT"
  fi
}
