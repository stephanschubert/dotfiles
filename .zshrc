# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="gentoo"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want disable red dots displayed while waiting for completion
# DISABLE_COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git git-flow osx complete-words-from-tmux-pane)
source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin
export NODE_PATH=/usr/local/lib/node_modules
export EDITOR=ec VISUAL=ec

###begin-jump-bash_profile
#
# Installation:
# jump >> ~/.bash_profile && source ~/.bash_profile
#

function jump {
  local newDir=$(JUMPPROFILE=1 command jump "$@");
  cd "$newDir";
}
alias j="jump -a"

###end-jump-bash_profile

alias e="emacsclient -nw -c"

# cd'ing into frequently-used directories
setopt auto_cd
cdpath=($HOME)

# rbenv support
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# Allow local Gem management
export GEM_HOME="$HOME/.gem"
export GEM_PATH="$HOME/.gem"
export PATH="$HOME/.gem/bin:$PATH"

# Ruby/Rails performance optimization
export RUBY_GC_MALLOC_LIMIT=60000000
export RUBY_FREE_MIN=200000

# Should improve performance for big apps (>100k lines) even more
export RUBY_GC_MALLOC_LIMIT=1000000000
export RUBY_FREE_MIN=500000
export RUBY_HEAP_MIN_SLOTS=40000

# MySQL start/stop helpers
export MYSQL_HOME=/usr/local/mysql
alias start_mysql='sudo $MYSQL_HOME/bin/mysqld_safe &'
alias stop_mysql='sudo $MYSQL_HOME/bin/mysqladmin shutdown'

# Cask is for Emacs what Bundler is for Ruby
export PATH="$HOME/.cask/bin:$PATH"

# Load every file from ~/.zsh.d
setopt extendedglob
for zshrc_snipplet in ~/.zsh.d/*[^~]; do
 source $zshrc_snipplet
done
