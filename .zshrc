# Load every file from ~/.zsdh.d
setopt extendedglob
for zshrc_snipplet in ~/.zsh.d/*[^~]; do
  source $zshrc_snipplet
done