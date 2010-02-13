#!/bin/bash

# Load custom mappings
xmodmap ~/.Xmodmap

# Load vmware-user
exec vmware-user

# invoke global X session script
. /etc/X11/Xsession
