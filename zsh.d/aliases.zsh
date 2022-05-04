# General
alias please='sudo $(fc -ln -1)'

# emacs
alias e='emacsclient -n -a emacs'
alias magit='emacsclient -n -e "(magit-status \"$(pwd)\")"'
alias eshell='emacsclient -n -e "(eshell-client)"'

# git
alias g='hub' # `brew install --HEAD hub` redirects any unknown commands to git.
alias gst='git status --short --branch'
alias gdf='git diff'
alias gdc='git diff --cached'
alias ga='git add'
alias gai='git add --interactive'
alias gc='git commit -m'
alias gca='git commit -a -m'
alias gcam='git commit --amend -C HEAD'
alias gp='git push'
alias gpr='git pull --rebase'
alias go='git checkout'
alias gl='git log --pretty=format:"%h %ad | %s%d [%an]" --graph --date=short'

# bundler
alias bx='bundle exec'

# ls
alias ls='ls -cG'
alias la='ls -acG'
alias ll='ls -lahG'
alias lsd="ls -lF ${colorflag} | grep --color=never '^d'"

# ls + ag
alias lsg='ls -G | rg'
alias lag='ls -aG | rg'
alias llg='ls -lahG | rg'

# Master chief
alias psa='ps auxf'
alias psg='ps aux | ag'

# Move multiple files
autoload -U zmv
alias mmv='noglob zmv -W'

# Docker
alias dm='docker-machine'
alias dangling='docker images -q --filter "dangling=true"'
alias exited='docker ps -a -q --filter "status=exited"'
alias untagged="docker images -a | grep \"^<none>\" | awk '{print $3}'"

# Google Chrome
alias ogc='sudo /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --remote-debugging-port=9222'

alias cp='cp -i' # confirm copy
alias mv='mv -i' # confirm move
alias weather='curl v2.wttr.in' # print weather for current location (https://github.com/chubin/wttr.in)

alias zshreload='source ~/.zshrc' # reload ZSH

# Postgres
alias pg_start="pg_ctl -D /usr/local/var/postgres start"
alias pg_stop="pg_ctl -D /usr/local/var/postgres stop"
