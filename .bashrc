# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

########################################
# Beginning of Debian-generated bashrc #
########################################

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi


# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto -B'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi
##################################
# End of Debian-generated bashrc #
##################################

# Nice prompt
PS1='[\A \u@\h:\w]\$ '

# Environment Variables
export EDITOR=vim
export CTAGS="-R --fields=+mnS" # --extra=+q --fields=+iaS

# Alias definitions 
alias la='ls -A'
alias l='ls -la'
alias gdiff='git difftool'
alias brc='source ~/.bashrc'
alias grepc='grep -rn --include=*.c'
alias grepcpp='grep -rn --include=*.cpp'
alias greph='grep -rn --include=*.h'
alias grepall='grep -rniI'
alias pwd='pwd -P'

# VI Mode!
set -o vi

# cd && ls
cl() {
  cd $*
  ls
}

# Beacon -- modeled after the Mystical MUD spell!
beacon() {
  if [ ! -f ~/.beacon_dir ]; then
    pwd > ~/.beacon_dir
    echo Set beacon: $PWD
  else
    BEACON_DIR=$(cat ~/.beacon_dir)
    cd $BEACON_DIR
    rm ~/.beacon_dir
  fi
}

# Silent make (except errors and warnings)
mk() {
  if [ $# -eq 0 ]; then
    echo "make"
    `make > /dev/null`
  else
    if [ $1 -gt 12 ]; then
      echo "I'm sure you didn't mean that.  Setting -j12."
      `make -j12 > /dev/null`
    else
      echo "make -j$1"
      `make -j$1 > /dev/null`
    fi
  fi
  if [ $? -eq 0 ]; then
    echo "Make OK."
  else
    echo "Make failed."
  fi
}

# Load computer-specific bashrc
if [ -f ~/.extended_bashrc ]; then
  source ~/.extended_bashrc
fi

