# cd to working directory of current emacs buffer
ecd() {
    cd ${(Q)~$(emacsclient -e '(with-current-buffer
                               (window-buffer (selected-window))
                               default-directory) ')}
}

# Print current emacs buffer
ecat() {
    () {
        emacsclient -e '(with-current-buffer (window-buffer (selected-window))
                      (write-region (point-min) (point-max) "'$1'" nil :quiet))
                   ' >/dev/null &&
            cat $1
    } =(:)
}
