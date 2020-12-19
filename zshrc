# Path to your oh-my-zsh and custom configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="agnoster"

# Locale
export LANG="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"

export ALTERNATE_EDITOR=""
export EDITOR="emacsclient -c -a ''"
# export EDITOR="~/dotfiles/emascclient-start.sh"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

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

# Enable support for `brew install thefuck`
#eval "$(thefuck --alias)"

#test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# https://github.com/dickeyxxx/gh#installation-for-oh-my-zsh
typeset +gx -A GITHUB
GITHUB[user]=stephanschubert

#alias magit='emacsclient -n -e "(magit-status)"'

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git gh nvm zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# Load all files from .zsh.d/ directory
if [ -d $HOME/.zsh.d ]; then
 for file in $HOME/.zsh.d/*.zsh; do
   # echo $file
   source $file
 done
fi

# Run `ls -la` automatically after each `cd`
function chpwd() {
    emulate -L zsh
    ls -la
}

#source /usr/local/share/zsh/site-functions/_awless

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
# [[ -f /Users/sschubert/.config/yarn/global/node_modules/tabtab/.completions/serverless.zsh ]] && . /Users/sschubert/.config/#yarn/global/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
# [[ -f /Users/sschubert/.config/yarn/global/node_modules/tabtab/.completions/sls.zsh ]] && . /Users/sschubert/.config/yarn/#global/node_modules/tabtab/.completions/sls.zsh

# Setup `enhancd`
# `git clone https://github.com/b4b4r07/enhancd ~/git/enhancd`
[ -f ~/git/enhancd/init.sh ] && source ~/git/enhancd/init.sh

# https://github.com/cantino/mcfly#installation
#if [ -f $(brew --prefix)/opt/mcfly/mcfly.bash ]; then
#  . $(brew --prefix)/opt/mcfly/mcfly.bash
#fi

# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
#[[ -f /Users/sschubert/git/hydra/node_modules/tabtab/.completions/slss.zsh ]] && . /Users/sschubert/git/hydra/node_modules/#tabtab/.completions/slss.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

autoload -U add-zsh-hook
load-nvmrc() {
    local node_version="$(nvm version)"
    local nvmrc_path="$(nvm_find_nvmrc)"

    if [ -n "$nvmrc_path" ]; then
        local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

        if [ "$nvmrc_node_version" = "N/A" ]; then
            nvm install
        elif [ "$nvmrc_node_version" != "$node_version" ]; then
            nvm use
        fi
    elif [ "$node_version" != "$(nvm version default)" ]; then
        echo "Reverting to nvm default version"
        nvm use default
    fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

# <-- Load completion config
source $HOME/.zsh/completion.zsh

# Initialize the completion system
autoload -Uz compinit

# Cache completion if nothing changed - faster startup time
typeset -i updated_at=$(date +'%j' -r ~/.zcompdump 2>/dev/null || stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)
if [ $(date +'%j') != $updated_at ]; then
    compinit -i
else
    compinit -C -i
fi

# Enhanced form of menu completion called `menu selection'
zmodload -i zsh/complist
# -->

source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOME/.zsh/history.zsh
source $HOME/.zsh/key-bindings.zsh

bindkey '^ ' autosuggest-accept

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/__tabtab.zsh ]] && . ~/.config/tabtab/__tabtab.zsh || true

# brew cask install google-cloud-sdk
source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform

# Setup `fzf` --
# `brew install fzf`
# To install useful key bindings and fuzzy completion:
# `$(brew --prefix)/opt/fzf/install`
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Set Spaceship ZSH as a prompt
# autoload -U promptinit; promptinit
# prompt spaceship
eval "$(starship init zsh)"

export PATH="$(npm-run-path):/usr/local/sbin:$PATH"
