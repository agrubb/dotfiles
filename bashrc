# -*- mode: sh -*-
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set to 256 color terminal
if [ $TERM = xterm ]; then
    export TERM=xterm-256color
fi

##############################################
##                 History
##############################################

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend
export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

##############################################
##                 Prompt
##############################################

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

function rainbow {
 echo "\n\[\033[30m\]a\[\033[31m\]b\[\033[32m\]c\[\033[33m\]d\[\033[34m\]e\[\033[35m\]f\[\033[36m\]g\[\033[37m\]h\n\[\033[01;30m\]a\[\033[01;31m\]b\[\033[01;32m\]c\[\033[01;33m\]d\[\033[01;34m\]e\[\033[01;35m\]f\[\033[01;36m\]g\[\033[01;37m\]h\[\033[00m\]"
}

function parse_git {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (git : \1)/'
}
PS1="\n[ \[\033[32m\]\u\[\033[00m\] @ \[\033[34m\]\h\[\033[00m\] : \[\033[31m\]\w\[\033[00m\]\[\033[35m\]\$(parse_git)\[\033[00m\] ]\n\[\033[33m\]\$\[\033[00m\] "

# PS1="\n[\[\033[32m\]\w]\[\033[0m\]\n\[\033[1;36m\]\u\[\033[1;33m\]\$\[\033[00m\] "
# PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac


##############################################
##                 Dircolors
##############################################

if type -p dircolors &> /dev/null; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

##############################################
##         Aliases / Custom Functions
##############################################

# enable color support of ls and also add handy aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

#alias e='TERM=xterm-256color emacs -nw'
#alias emacs='TERM=xterm-256color emacs -nw'
alias e='emacs -nw'
alias tmux='tmux -2'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Shamelessly stolen from http://raim.codingfarm.de/blog/2013/01/30/tmux-update-environment/
function update-tmux-environment {
    if [[ -z $TMUX ]]; then
        echo "You aren't running inside of TMUX, dummy!"
    else
        local v
        while read v; do
            if [[ $v == -* ]]; then
                unset ${v/#-/}
            else
                # Add quotes around the argument
                v=${v/=/=\"}
                v=${v/%/\"}
                eval export $v
            fi
        done < <(tmux show-environment)
    fi
}

##############################################
##  Fix any aliases for local settings, etc.
##############################################
if [ -f ~/.bashrc.local ]; then
    . ~/.bashrc.local
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

# if [ -f ~/.bash_aliases ]; then
#     . ~/.bash_aliases
# fi

##############################################
##                Completion
##############################################

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi
