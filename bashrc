# --------------------------- BASH CONFIG ------------------------------------
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Nice prompt
PS1='[\A \u@\h:\w]\$ '

# VI Mode!
set -o vi

# --------------------- ENVIRONMENT VARIABLES --------------------------------
  export PATH=$HOME/.local/bin:$PATH
if [[ "$OSTYPE" == "darwin"* ]]; then
  export PATH=/opt/homebrew/bin:$PATH
  export PATH=$PATH:/Applications/MacVim.app/Contents/bin
  export GDIFF="kdiff3"
elif [[ "$OS" == "Windows_NT" ]]; then
  PS1='[\A \w]\$ '
  export GDIFF="winmerge"
else
  export PATH=$HOME/.local/bin:$PATH
  export GDIFF="meld"
fi

export EDITOR=vim
export CTAGS="--extra=+q --fields=+imnaS --language-force=C++"



# ------------------------------- ALIASES ------------------------------------

if [[ "$OSNAME" == "darwin"* ]]; then
  alias ls='ls -G'
else
  alias ls='ls --color=auto'
fi

alias la='ls -A'
alias l='ls -latr'
alias pwd='pwd -P'
alias brc='source ~/.bashrc'
alias df="df -h"

# Grep aliases
alias grep="grep --color=auto"
alias grepc='grep -rnI --include="*.cpp" --include="*.h" --include="*.hpp"'
alias grepcpp='grep -rnI --include="*.cpp" --exclude="*moc*"'
alias greph='grep -rnI --include="*.h" --exclude="*moc*"'
alias greppro='grep -rnI --include="*.pr*"'
alias greppl='grep -rnI --include="*.pl"'
alias greppy='grep -rnI --include="*.py"'
alias grepcmake='grep -rniI --include="*CMake*"'

# Development aliases
if [[ "$OS" == "Windows_NT" ]]; then
  alias mk="msbuild"
else
  alias mk="make -j16 > /dev/null && echo \"Make OK\""
  alias cachegrind='valgrind --tool=cachegrind --trace-children=yes'
  alias listdefined="nm -D --defined-only --demangle"
  alias create-tags='ctags -R *'
fi

alias gdiff="git difftool -y"
alias findcode='find \( -name "*.cpp" -o -name "*.h" \) -name '
alias findclass='find -name "*.h" -name '
alias killcontainers='docker stop $(docker ps -q) && docker system prune -f && docker volume prune -f'

# Environment
alias path="echo $PATH | sed 's/:/\n/g'"
alias libpath="echo $LD_LIBRARY_PATH | sed 's/:/\n/g'"

# Misc aliases
alias dush="du -hs * | sort -h"
alias duall="du -ahd1 | sort -h"


# cd && ls
cl() {
  cd $*
  ls
}

# ------------------------- Custom Commands ----------------------------------

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

addpath() {
  export PATH="$*":"$PATH"
}

addlibpath() {
  export LD_LIBRARY_PATH="$*":"$PATH"
}

rununtilfailed() {
  i=0
  while true;
    i=$(($i + 1))
    if [ $(($i % 10)) -eq 0 ]; then
      echo "Attempt number $i"
    fi
    do $*
    if [ $? -ne 0 ]; then
      break
    fi
  done
}

