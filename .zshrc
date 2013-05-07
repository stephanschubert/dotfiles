export PATH=$PATH:$HOME/bin

# Load every file from ~/.zsh.d
setopt extendedglob
for zshrc_snipplet in ~/.zsh.d/*[^~]; do
  source $zshrc_snipplet
done

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# Ruby performance settings
# See https://gist.github.com/burke/1688857

export RUBY_GC_MALLOC_LIMIT=60000000
export RUBY_FREE_MIN=200000
export RUBY_GC_MALLOC_LIMIT=1000000000
export RUBY_FREE_MIN=500000
export RUBY_HEAP_MIN_SLOTS=40000
