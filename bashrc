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

export VIMDIR='~/.vim/'
export EDITOR='vim'
export CVSEDITOR='vim'
export LESSKEY='~/.lesskey'
export HISTIGNORE='&: *:l:ll:history*:ls:cd:clear:..:...:....:p:dirs:1:2:3:4:5:6:7:8:9'
export HISTTIMEFORMAT='%F %T '
export CVS_RSH="ssh"
export CLICOLOR="yes"
export TERM=xterm-256color

# Set appropriate ls alias
case $(uname -s) in
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
alias ll='ls -l'
alias la='ll -a'
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
