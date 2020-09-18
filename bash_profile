if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
true
# added by Anaconda2 2.4.1 installer
export PATH="/Users/max/anaconda/bin:$PATH"

export PATH="/home/max/.linuxbrew/bin:$PATH"
export MANPATH="/home/max/.linuxbrew/share/man:$MANPATH"
export INFOPATH="/home/max/.linuxbrew/share/info:$INFOPATH"
