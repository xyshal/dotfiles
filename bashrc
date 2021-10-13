# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Nice prompt
PS1='[\A \u@\h:\w]\$ '

# Environment Variables
export EDITOR=vim
export CTAGS="-R --fields=+mnS" # --extra=+q --fields=+iaS

# Alias definitions 
if [[ "$OSNAME" == "darwin"* ]]; then
  alias ls='ls -G'
else
  alias ls='ls --color=auto'
fi
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
    if [ $1 -gt 16 ]; then
      echo "I'm sure you didn't mean that.  Setting -j16."
      `make -j16 > /dev/null`
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


