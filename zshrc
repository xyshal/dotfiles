# --------------------- ENVIRONMENT VARIABLES --------------------------------

export EDITOR=vim
export GDIFF="meld"
export CTAGS="--extra=+q --fields=+imnaS --language-force=C++"

# ------------------------------- ALIASES ------------------------------------

# Various command aliases
alias ls="ls --color=auto"
alias l="ls -latr"
alias pwd="pwd -P"
alias brc="source ~/.zshrc"
alias df="df -h"

# Grep aliases
alias grep="grep --color=auto"
alias grepc='grep -rnI --include="*.cpp" --include="*.h" --include="*.hpp"'
alias grepcpp='grep -rnI --include="*.cpp" --exclude="*moc*"'
alias greph='grep -rnI --include="*.h" --exclude="*moc*"'
alias greppro='grep -rnI --include="*.pr*"'
alias greppl='grep -rnI --include="*.pl"'
alias grepall='grep -rnI --exclude "*build/*" --exclude "*svn*" --exclude "tags" --exclude "*Makefile*"'

# Development aliases
alias gdiff="git difftool -y"
alias mk="make -j16 > /dev/null && echo \"Make OK\""
alias cachegrind='valgrind --tool=cachegrind --trace-children=yes'
alias listdefined="nm -D --defined-only --demangle"
alias findcode='find \( -name "*.cpp" -o -name "*.h" \) -name '
alias findclass='find -name "*.h" -name '

# Environment
alias path="echo $PATH | sed 's/:/\n/g'"
alias libpath="echo $LD_LIBRARY_PATH | sed 's/:/\n/g'"

# Misc aliases
alias dush="du -hs * | sort -h"
alias duall="du -ahd1 | sort -h"

# Global aliases (appending to other commands)
alias -g L=" | less"
alias -g F=" > ~/tmp/tmp && gvim ~/tmp/tmp"


# ------------------------- Custom Commands ----------------------------------

# If things go longer than 30 seconds, let's report exactly how long
REPORTTIME=5
TIMEFMT="%*E total (status $?)"

# Always ls after cd
function chpwd() {
  ls
}

addpath() {
  export PATH="$*":"$PATH"
}

addlibpath() {
  export LD_LIBRARY_PATH="$*":"$PATH"
}

# Pipe things to this, e.g. `ls -ltr | sumcol 5`
sumcol()
{
  awk "{sum+=\$$1} END {print sum}"
}

# Run until failed
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

# ------------------ ZSH GENERAL CONFIGURATION -------------------------------

# Completer definitions
zstyle ':completion:*' completer _complete _ignored _approximate
zstyle :compinstall filename '/home/ops/.zshrc'

# New completer stuff to get custom things working?
#zstyle ':completion:*' verbose yes
#zstyle ':completion:*:descriptions' format '%B%d%b'
#zstyle ':completion:*:messages' format '%d'
#zstyle ':completion:*:warnings' format 'No matches for: %d'
#zstyle ':completion:*' group-name ''

#fpath=($HOME/.zsh/completion $fpath)
autoload -Uz compinit
#autoload -U ~/.zsh/completion/*(:t)
compinit

# History configuration
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=10000

# Boolean options
setopt autocd # If you type /usr , will cd /usr
unsetopt beep

# Turn off stupid warning about deleting things
setopt rm_star_silent

# VIM mode
bindkey -v

# Enable colors
autoload colors zsh/terminfo
if [[ "$terminfo[colors]" -ge 8 ]]; then
  colors
fi

# Prompt
export PROMPTCHARS="$"
PROMPT="[%T %~]%# "
RPROMPT="[%n@%m] %(?.%{${fg[green]}%}O.%{${fg[red]}%}X)%{${fg[default]}%}"

# Bindkeys

#create a zkbd compatible hash;
#to add other keys to this hash, see: man 5 terminfo
typeset -A key

key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

# setup key accordingly
[[ -n "${key[Home]}"    ]]  && bindkey  "${key[Home]}"    beginning-of-line
[[ -n "${key[End]}"     ]]  && bindkey  "${key[End]}"     end-of-line
[[ -n "${key[Insert]}"  ]]  && bindkey  "${key[Insert]}"  overwrite-mode
[[ -n "${key[Delete]}"  ]]  && bindkey  "${key[Delete]}"  delete-char
[[ -n "${key[Up]}"      ]]  && bindkey  "${key[Up]}"      up-line-or-history
[[ -n "${key[Down]}"    ]]  && bindkey  "${key[Down]}"    down-line-or-history
[[ -n "${key[Left]}"    ]]  && bindkey  "${key[Left]}"    backward-char
[[ -n "${key[Right]}"   ]]  && bindkey  "${key[Right]}"   forward-char

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
function zle-line-init () {
  echoti smkx
}

function zle-line-finish () {
  echoti rmkx
}

zle -N zle-line-init
zle -N zle-line-finish  

# Restore ctrl+r in vi i
bindkey -M viins '^r' history-incremental-search-backward
bindkey -M vicmd '^r' history-incremental-search-backwardmode

# Core files, please
ulimit -c unlimited

