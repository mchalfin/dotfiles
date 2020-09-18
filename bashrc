#-------------------
# stty and inputs
#-------------------

case "$-" in
*i*)
stty kill undef
bind -f ~/.inputrc
stty erase ^?
esac

#-------------------
# Options
#-------------------

# by default, sometimes non zero return values are ignored if the result is
# piped to another process, which in turn had a zero return value. Having the
# build fail in this case is preferred.
set -o pipefail

shopt -s expand_aliases
shopt -s checkwinsize
shopt -s no_empty_cmd_completion
shopt -s cmdhist

#-------------------
# Environment variables
#-------------------

#export BASH_ENV='~/.bashrc' # so piping to 'bash' doesn't require 'bash -l'
export VIMDIR='~/.vim/'
export EDITOR='vim'
export CVSEDITOR='vim'
# MALLOC_OPTIONS deprecated in latest fbsd version
export MALLOC_OPTIONS='J'
if [ -z "$SCHED_JID" ]; then
    export MALLOC_CONF=junk:true
fi
#export PYTHONDONTWRITEBYTECODE='1'
export LESSKEY='~/.lesskey'
export HISTIGNORE='&: *:l:ll:history*:ls:cd:clear:..:...:....:p:dirs:1:2:3:4:5:6:7:8:9'
export HISTTIMEFORMAT='%F %T '
export CVS_RSH="ssh"
export CLICOLOR="yes"
export TERM=xterm-256color

# Set appropriate ls alias
case $(uname -s) in
    FreeBSD)
        export LSCOLORS="DxGxFxdxCxDxDxhbadExEx"
        alias ls="ls -hFG -D '%Y%m%d %T'"
    ;;
#    Darwin)
#        alias ls="gls -hFG --color --time-style='+%Y%m%d %T'"
#    ;;
    Linux)
        export ROSVER="linux"
        export LS_COLORS="di=1;34;40:tw=1;34;40:ow=1;34;40:fi=0:ln=36:pi=5:so=5:bd=5:cd=5:or=31:mi=0:ex=33:*.rpm=90"
        alias ls="ls -hF --color --time-style='+%Y%m%d %T'"
    ;;
esac

#-------------------
# Personnal Aliases
#-------------------
alias bell='echo -ne "\a"'
alias vi='vim'
alias view='vim -R'
alias sb='source ~/.bashrc'
alias grep='egrep'
alias g='egrep --color=auto'
alias gub='egrep --line-buffered'
alias h='history 25'
alias bc='bc -l'
#alias j='jobs -l' # This is used for autojump now
alias ll='ls -l'
alias la='ll -a'
alias l='ll'
alias lll='ll'
alias llll='ll'
alias lllll='ll'
alias llllll='ll'
alias which='type -all'
alias mkdir='mkdir -p'
alias R='R --no-save'
#http://askubuntu.com/questions/20530/how-can-i-find-the-location-on-the-desktop-of-a-window-on-the-command-line
alias winfo='xwininfo -id $(xprop -root | gawk "/_NET_ACTIVE_WINDOW\(WINDOW\)/{print \$NF}")'
alias myxargs='tr "\n" "\0" | xargs -0'
alias shuf="perl -MList::Util=shuffle -e'print shuffle<>'"
alias findvis="find . \( ! -regex '.*/\..*' \) -type f"

# tailoring 'less'
alias  more='less'
export PAGER=less
export LESSOPEN='|$HOME/.dotfiles/lesspipe.sh %s 2>&-'
export LESS='--ignore-case --hilite-unread  --window=-4 --LONG-PROMPT -R -X -P%t?f%f :stdin .?pb%pb\%:?lbLine %lb:?bbByte %bb:-...' # Use this if lesspipe.sh exists.
#export LESS=-R

umask 000

##--------------
## autojump and dir navigation
##--------------
#
#export AUTOJUMP_IGNORE_CASE=1
#if hash brew 2>/dev/null; then
#    [[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh
#else
#    [[ -s ~/.autojump/etc/profile.d/autojump.sh ]] && . ~/.autojump/etc/profile.d/autojump.sh
#fi

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias d='(dirs -v | gawk "{print \$1,\$2,\$1}" | column -t | gawk "{ if((getline nextLine) > 0) {print \"\033[1;33m\" \$0 \"\n\033[1;34m\" nextLine} else {print \"\033[1;33m\" \$0} }"; echo -en "\033[0m")'
alias 1='cd `dirs -l +1`; d'
alias 2='cd `dirs -l +2`; d'
alias 3='cd `dirs -l +3`; d'
alias 4='cd `dirs -l +4`; d'
alias 5='cd `dirs -l +5`; d'
alias 6='cd `dirs -l +6`; d'
alias 7='cd `dirs -l +7`; d'
alias 8='cd `dirs -l +8`; d'
alias 9='cd `dirs -l +9`; d'
alias 10='cd `dirs -l +10`; d'
alias 11='cd `dirs -l +11`; d'
alias 12='cd `dirs -l +12`; d'
alias 13='cd `dirs -l +13`; d'
alias 14='cd `dirs -l +14`; d'
alias 15='cd `dirs -l +15`; d'
alias 16='cd `dirs -l +16`; d'
alias 17='cd `dirs -l +17`; d'
alias 18='cd `dirs -l +18`; d'
alias 19='cd `dirs -l +19`; d'

#--------------
# Magic
#--------------

#http://www.davidpashley.com/articles/xterm-titles-with-bash.html
#case "$TERM" in
#xterm*|rxvt*)
#    set -o functrace
#    trap 'echo -ne "\e]0;" `basename $PWD` "\007"' DEBUG
#    PS1="\e]0;\s\007$PS1"
#    ;;
#*)
#    ;;
#esac
#PROMPT_COMMAND='echo -ne "\e]0;" `basename $PWD` "\007"'

#---------------
# Shell Prompt
#---------------

function TRAPUSR2()
{
    source ~/.bashrc
}
trap TRAPUSR2 USR2

RED=$'\e[1;31m'
BLUE=$'\e[1;34m'
CYAN=$'\e[1;36m'
PURPLE=$'\e[1;35m'
GREEN=$'\e[1;32m'
NONE=$'\e[0m'

UCOLOR=$CYAN
if [[ "$(whoami)" != "max" ]]; then
    # display the user in red if i'm sudo'd to someone else
    UCOLOR=$RED
fi

export PS1='`if [ $? -eq 0 ];then echo -n "\[${GREEN}\][$?] ";else echo -n "\[${RED}\][$?] ";fi;echo -n "\[${NONE}\]\t \[${PURPLE}\][\[${UCOLOR}\]\u@\[${CYAN}\]\h\[${PURPLE}\]] \[${GREEN}\]$(pwd)\[${NONE}\] > ";`'

#-----------------------------------
# File & strings related functions:
#-----------------------------------

# Find a file with a pattern in name:
function ff()
{ find . -type f -iname '*'$*'*' -ls ; }

# Find a file with pattern $1 in name and Execute $2 on it:
function fe()
{ find . -type f -iname '*'$1'*' -exec "${2:-file}" {} \;  ; }

# find pattern in a set of filesand highlight them:
function fstr()
{
    OPTIND=1
    local case=""
    local usage="fstr: find string in files.
Usage: fstr [-i] \"pattern\" [\"filename pattern\"] "
    while getopts :it opt
    do
        case "$opt" in
        i) case="-i " ;;
        *) echo "$usage"; return;;
        esac
    done
    shift $(( $OPTIND - 1 ))
    if [ "$#" -lt 1 ]; then
        echo "$usage"
        return;
    fi
    local SMSO=$(tput smso)
    local RMSO=$(tput rmso)
    find . -type f -name "${2:-*}" -print0 |
    xargs -0 grep -sn ${case} "$1" 2>&- | \
    sed "s/$1/${SMSO}\0${RMSO}/gI" | more
}

function cuttail() # Cut last n lines in file, 10 by default.
{
    nlines=${2:-10}
    sed -n -e :a -e "1,${nlines}!{P;N;D;};N;ba" $1
}

function lowercase()  # move filenames to lowercase
{
    for file ; do
        filename=${file##*/}
        case "$filename" in
        */*) dirname==${file%/*} ;;
        *) dirname=.;;
        esac
        nf=$(echo $filename | tr A-Z a-z)
        newname="${dirname}/${nf}"
        if [ "$nf" != "$filename" ]; then
            mv "$file" "$newname"
            echo "lowercase: $file --> $newname"
        else
            echo "lowercase: $file not changed."
        fi
    done
}

function swap()         # swap 2 filenames around
{
    local TMPFILE=tmp.$$
    mv "$1" $TMPFILE
    mv "$2" "$1"
    mv $TMPFILE "$2"
}

function cd()
{
   MAX=20
   LEN=${#DIRSTACK[@]}

   if [ $# -eq 0 ] || [ "$1" = "-" ]; then
      builtin cd "$@"
      pushd -n $OLDPWD > /dev/null
   else
      pushd "$@" > /dev/null || return 1
   fi

   if [ $LEN -gt 1 ]; then
      seqcommand="seq"
      which seq 1>/dev/null 2>&-1
      if [ $? -ne 0 ]; then
         seqcommand="jot -"
      fi
      for i in `$seqcommand 1 $LEN`; do
         eval p=~$i
         if [ "$p" = "$PWD" ]; then
            popd -n +$i > /dev/null
            break
         fi
      done
   fi

   if [ $LEN -ge $MAX ]; then
      popd -n -0 > /dev/null
   fi
}

# https://chris-lamb.co.uk/2010/04/22/locating-source-any-python-module/
function cdp () {
cd "$(python -c "import sys, imp, os
path = sys.path
for i in '${1}'.split('.'): path = [imp.find_module(i,path)[1],]
path = path[0] if os.path.isdir(path[0]) else os.path.dirname(path[0])
print path")"
}
