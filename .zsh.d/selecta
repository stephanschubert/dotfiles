function exists { which $1 &> /dev/null }

if exists selecta; then
  function selecta_select_history() {
    local tac
    exists gtac && tac="gtac" || { exists tac && tac="tac" || { tac="tail -r" } }
    BUFFER=$(fc -l -n 1 | eval $tac | selecta $LBUFFER)
    CURSOR=$#BUFFER         # move cursor
    zle -R -c               # refresh
  }

  zle -N selecta_select_history
  bindkey '^R' selecta_select_history

  function ppgrep() {
    if [[ $1 == "" ]]; then
      SELECTA=selecta
    else
      SELECTA="selecta $1"
    fi
    ps aux | eval $SELECTA | awk '{ print $2 }'
  }

  function ppkill() {
    if [[ $1 =~ "^-" ]]; then
      QUERY="" # options only
    else
      QUERY=$1 # with a query
      [[ $# > 0 ]] && shift
    fi
    ppgrep $QUERY | xargs kill $*
  }

  function switch-branch() {
    git branch | cut -c 3- | selecta | xargs git checkout
  }

  function checkout-branch() {
    branch=${1:-origin}
    git branch -r | grep "$branch/" | cut -d'/' -f 2- | selecta | xargs -I{} git checkout -b '{}' $branch/'{}'
  }

  function p() { cd $(find ~/git ~/repos -type d -maxdepth 1 | selecta) }
fi
