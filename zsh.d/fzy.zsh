# Follow the install instructions at https://github.com/jhawthorn/fzy first.

function exists { which $1 &> /dev/null }

if exists fzy; then
  function fzy_select_history() {
    local tac
    exists gtac && tac="gtac" || { exists tac && tac="tac" || { tac="tail -r" } }
    BUFFER=$(fc -l -n 1 | eval $tac | fzy $LBUFFER)
    CURSOR=$#BUFFER         # move cursor
    zle -R -c               # refresh
  }

  zle -N fzy_select_history
  bindkey '^R' fzy_select_history

  function ppgrep() {
    if [[ $1 == "" ]]; then
      FZY=fzy
    else
      FZY="fzy $1"
    fi
    ps aux | eval $FZY | awk '{ print $2 }'
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
    git branch | cut -c 3- | fzy | xargs git checkout
  }

  function checkout-branch() {
    branch=${1:-origin}
    git branch -r | grep "$branch/" | cut -d'/' -f 2- | fzy | xargs -I{} git checkout -b '{}' $branch/'{}'
  }

  function p() { cd $(find ~/git ~/repos -type d -maxdepth 1 | fzy) }

  function fzy-find {
    trap '' INT
    zle -U "$(find . 2>/dev/null | ag -v '^.$|/.svn|/.git' | fzy)"
    zle redisplay
    trap - INT
  }

  zle -N fzy-find
  bindkey '^t' fzy-find
fi
