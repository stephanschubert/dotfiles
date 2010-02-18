export PATH=$PATH:$HOME/bin

if [[ -s /home/jazen/.rvm/scripts/rvm ]] && [[ $rvm_loaded_flag != 1 ]] ; then source /home/jazen/.rvm/scripts/rvm ; fi

# Load every file from ~/.zsdh.d
setopt extendedglob
for zshrc_snipplet in ~/.zsh.d/*[^~]; do
  source $zshrc_snipplet
done
