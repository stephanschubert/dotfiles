# Amazon Q pre block (keep at top)
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"

# PATH modifications (consolidated)
path=(
  /opt/homebrew/bin
  /opt/homebrew/opt/python@3.10/libexec/bin
  /Library/Frameworks/Python.framework/Versions/3.11/bin
  /opt/homebrew/opt/openjdk@21/bin
  $HOME/.babashka/bbin/bin
  $HOME/.local/bin
  $HOME/.pnpm
  $HOME/.codeium/windsurf/bin
  $HOME/.antigravity/antigravity/bin
  $path
)
typeset -U path fpath
export PATH

# CDPATH for quick directory switching
cdpath=(~ ~/Dropbox/git)

# Directory hash shortcuts (~git)
hash -d git=~/Dropbox/git

# pnpm
export PNPM_HOME="$HOME/.pnpm"

# Oh My Zsh variables (must be set BEFORE sourcing oh-my-zsh)
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Oh My Zsh setup
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="dracula"
plugins=(git gh zsh-fzf-history-search)
[[ -f $ZSH/oh-my-zsh.sh ]] && source $ZSH/oh-my-zsh.sh

# Locale settings
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

# Editor settings
export ALTERNATE_EDITOR=""
export EDITOR="emacsclient -c -a ''"

# Shell options
setopt extendedglob
unsetopt nomatch       # Allow [ or ] anywhere
setopt NO_FLOW_CONTROL
setopt INTERACTIVE_COMMENTS
setopt AUTO_PUSHD PUSHD_IGNORE_DUPS PUSHD_SILENT
setopt CORRECT         # Suggest corrections for mistyped commands

# Word characters (removed / so path segments are separate words for ^W)
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# Auto-show timing for commands taking longer than 5 seconds
REPORTTIME=5

# History settings
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

setopt APPEND_HISTORY         # Append to history file
setopt HIST_IGNORE_DUPS       # Ignore consecutive duplicates
setopt HIST_IGNORE_SPACE      # Ignore commands starting with a space
setopt EXTENDED_HISTORY       # Save timestamps and duration
setopt SHARE_HISTORY          # Share history across all sessions

setopt HIST_EXPIRE_DUPS_FIRST # Drop older dupes first when trimming history
setopt HIST_VERIFY            # Show expanded history line before executing
setopt INC_APPEND_HISTORY     # Write history immediately for shared sessions
setopt HIST_IGNORE_ALL_DUPS   # Remove any prior duplicate before adding
setopt HIST_FIND_NO_DUPS      # ^R and fc skip duplicate matches

# Optional enhancements (uncomment as desired):
# setopt HIST_REDUCE_BLANKS    # Trim excess whitespace from commands
# setopt HIST_NO_STORE         # Don't save history commands (e.g., 'history' itself)

# Completion settings (hardcoded brew prefix for faster startup)
if [[ -d /opt/homebrew/share/zsh-completions ]]; then
  fpath=("/opt/homebrew/share/zsh-completions" $fpath)
fi
fpath=("$HOME/.zsh/completions" $fpath)
autoload -Uz compinit
# NOTE: If you get insecure directory warnings, run:
# chmod go-w /opt/homebrew/share/zsh-completions
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' menu select
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$HOME/.zcompcache"
zstyle ':completion:*' rehash true
compinit -C

# Custom zsh files (with existence checks)
[[ -f $HOME/.zsh/worktree-manager.zsh ]] && source $HOME/.zsh/worktree-manager.zsh
[[ -f $HOME/.zsh/functions.zsh ]] && source $HOME/.zsh/functions.zsh
[[ -f $HOME/.zsh/aliases.zsh ]] && source $HOME/.zsh/aliases.zsh

# Visual tweaks
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

# GitHub settings
typeset +gx -A GITHUB
GITHUB[user]=stephanschubert

chpwd() {
  emulate -L zsh
  ls -F
}

# Emacs keybindings
bindkey -e
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^U' kill-whole-line
bindkey '^W' backward-kill-word
bindkey '\ed' kill-word
bindkey '\ep' up-line-or-history
bindkey '\en' down-line-or-history
bindkey '^_' undo
bindkey '^X^U' undo
bindkey '^I' expand-or-complete
bindkey '\e/' expand-word
bindkey '^X^E' edit-command-line
bindkey '^ ' autosuggest-accept
bindkey '^R' history-incremental-pattern-search-backward
bindkey '^S' history-incremental-pattern-search-forward
autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic

# Sudo toggle widget (Esc-Esc prepends sudo)
sudo-command-line() {
  [[ -z $BUFFER ]] && zle up-history
  [[ $BUFFER != sudo\ * ]] && BUFFER="sudo $BUFFER"
  zle end-of-line
}
zle -N sudo-command-line
bindkey '\e\e' sudo-command-line

# External tools and completions
setopt PROMPT_SUBST
command -v starship >/dev/null && eval "$(starship init zsh)"
[[ -f /opt/homebrew/etc/profile.d/autojump.sh ]] && . /opt/homebrew/etc/profile.d/autojump.sh

# Set up fzf key bindings and fuzzy completion
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --style=numbers --line-range=:500 {} 2>/dev/null || cat {}'"
export FZF_ALT_C_OPTS="--preview 'ls -la {}'"
if [[ -r /opt/homebrew/opt/fzf/shell/completion.zsh ]]; then
  source /opt/homebrew/opt/fzf/shell/completion.zsh
fi
if [[ -r /opt/homebrew/opt/fzf/shell/key-bindings.zsh ]]; then
  source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
fi

# asdf version manager (must come after PATH modifications to take precedence)
asdf() {
  unset -f asdf
  . /opt/homebrew/opt/asdf/libexec/asdf.sh
  asdf "$@"
}

# Zsh autosuggestions configuration
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

# Zsh enhancements (with existence checks)
[[ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && \
  source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[[ -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && \
  source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

setopt NO_BEEP
setopt NO_LIST_BEEP

# Node optimization
export NODE_COMPILE_CACHE=~/.cache/nodejs-compile-cache

# Task Master aliases
alias tm='task-master'
alias taskmaster='task-master'
alias reload='source ~/.zshrc'

# Secrets (API keys stored separately)
[[ -f ~/.secrets ]] && source ~/.secrets

# Claude/Kimi function (uses subshell to avoid polluting environment)
kimi() {
  (
    export ANTHROPIC_BASE_URL=https://api.moonshot.ai/anthropic
    export ANTHROPIC_AUTH_TOKEN=$KIMI_API_KEY
    claude "$@"
  )
}

# Amazon Q post block (keep at bottom)
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"
