# -*- mode: sh -*-
if [ -f ~/.bashrc ]; then
         . ~/.bashrc
fi

if [ -f ~/.profile ]; then
    . ~/.profile
fi

##############################################
##  Fix any paths for local settings, etc.
##############################################
if [ -f ~/.bash_profile.local ]; then
    . ~/.bash_profile.local
fi