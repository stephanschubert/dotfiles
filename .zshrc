# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd beep extendedglob nomatch notify
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/jazen/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

parse_git_branch() {
  (git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/') || return
}

autoload -U colors
colors
setopt prompt_subst
PROMPT='%n@%m %{$fg[red]%}%100c %{$fg[blue]%}$(parse_git_branch)%{$reset_color%}> '