# Enables paste support using Ctrl-v 
#
# Requires the xclip utitility as 
# interface to X11's clipboard.

paste-from-clipboard() {
  CLIPOUT=`xclip -out`
  BUFFER=$LBUFFER$CLIPOUT$RBUFFER
}

# Bind a widget with the same name as the function
zle -N paste-from-clipboard paste-from-clipboard

# Make insert paste from clipboard by binding it to the widget.
# If you hit ctrl-v and then the key, it shows you the extended code to use.
bindkey '^V' paste-from-clipboard

