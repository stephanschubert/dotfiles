# emacs
alias e='emacsclient -nw -c'
alias se='sudo emacsclient -nw -c'

# git
alias g='hub' # `brew install --HEAD hub` redirects any unknown commands to git.
alias gst='git status'
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
alias lsd='ls -d */'

# ls + ag
alias lsg='ls -G | ag'
alias lag='ls -aG | ag'
alias llg='ls -lahG | ag'

# Searching Ruby source with ag
alias agr='ag --ruby --ignore spec --ignore db/migrate'

# ruby/rails
alias rc='ruby script/console'
alias rcp='ruby script/console production'
alias rs='ruby script/server'
alias td='tail -f log/development.log'
alias tp='tail -f log/production.log'

# Master chief
alias psa='ps auxf'
alias psg='ps aux | ag'

# Move multiple files
autoload -U zmv
alias mmv='noglob zmv -W'
