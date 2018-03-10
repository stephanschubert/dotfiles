# Path to your oh-my-zsh and custom configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="agnoster"

export ALTERNATE_EDITOR=""
export EDITOR="emacsclient -nw"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Use `brew install keychain` as nicer frontend to ssh-agent.
eval `keychain --eval --agents ssh --inherit any jazen`

source $ZSH/oh-my-zsh.sh

export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

setopt extendedglob

# Emulate bash's behaviour when using !! to run the last command again
# without the need to press <enter> twice.
setopt NO_HIST_VERIFY

# Don't share history across panes
setopt nosharehistory

# Allow [ or ] whereever you want
unsetopt nomatch

eval "$(rbenv init -)"

# Ruby performance settings

export RUBY_GC_HEAP_INIT_SLOTS=2000000
export RUBY_GC_HEAP_FREE_SLOTS=500000
export RUBY_HEAP_FREE_MIN=20000
export RUBY_HEAP_SLOTS_INCREMENT=200000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
export RUBY_GC_MALLOC_LIMIT=100000000

# See https://gist.github.com/burke/1688857

# export RUBY_HEAP_MIN_SLOTS=40000
# export RUBY_FREE_MIN=500000
# export RUBY_GC_MALLOC_LIMIT=1000000000

# This loads NVM
[ -s $HOME/.nvm/nvm.sh ] && . $HOME/.nvm/nvm.sh

# Customize PATH to your needs...
#export PATH=$HOME/.rbenv/bin:$PATH # TODO Still needed?
export PATH="$HOME/.cask/bin:$PATH" # Add Cask
export PATH="/usr/local/sbin:$PATH" # Some brew packages put their files here

# Add binaries from `brew install coreutils gnu-sed` to PATH
export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
export PATH="$(brew --prefix gnu-sed)/libexec/gnubin:$PATH"

# Add tab-completion for teamocil & git
compctl -g '~/.teamocil/*(:t:r)' teamocil
compdef g=git
[ -f ~/git/zaw/zaw.zsh ] && source ~/git/zaw/zaw.zsh

# Short of learning how to actually configure OSX, here's a hacky way to use
# GNU manpages for programs that are GNU ones, and fallback to OSX manpages otherwise
alias man='_() { echo $1; man -M $(brew --prefix coreutils)/libexec/gnuman $1 1>/dev/null 2>&1; if [ "$?" -eq 0 ]; then man -M $(brew --prefix coreutils)/libexec/gnuman $1; else man $1; fi }; _'

# Add support for tracking time spent in the shell (Timing app)
PROMPT_TITLE='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}\007"'
export PROMPT_COMMAND="${PROMPT_COMMAND} ${PROMPT_TITLE}; "

# Enable support for `brew install thefuck`
eval "$(thefuck --alias)"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# https://github.com/dickeyxxx/gh#installation-for-oh-my-zsh
typeset +gx -A GITHUB
GITHUB[user]=jazen

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(brew docker git ruby nvm gh zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# Load all files from .zsh.d/ directory
if [ -d $HOME/.zsh.d ]; then
  for file in $HOME/.zsh.d/*.zsh; do
    source $file
  done
fi

# Run `ls -la` automatically after each `cd`
function chpwd() {
    emulate -L zsh
    ls -la
}
# Setup `fzf` --
# `brew install fzf`
# To install useful key bindings and fuzzy completion:
# `$(brew --prefix)/opt/fzf/install`
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Setup `enhancd`
# `git clone https://github.com/b4b4r07/enhancd ~/git/enhancd`
[ -f ~/git/enhancd/init.sh ] && source ~/git/enhancd/init.sh

# Setup syntax highlighting
# `git clone git@github.com:zsh-users/zsh-syntax-highlighting.git ~/git/zsh-syntax-highlighting`
[ -f ~/git/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source ~/git/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
