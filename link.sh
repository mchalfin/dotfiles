# todo: do we need these?
#ln -f -s ~/.dotfiles/Rprofile ~/.RProfile

# todo: really understand these
#ln -f -s ~/.dotfiles/lesskey ~/.lesskey
#ln -f -s ~/.dotfiles/lesskey-in ~/.lesskey-in
#ln -f -s ~/.dotfiles/gvimrc ~/.gvimrc

# peter made vim pretty nice
ln -f -s ~/.dotfiles/vim ~/.vim
ln -f -s ~/.dotfiles/vimrc ~/.vimrc

# a bunch of stty configs for better
# terminal input (e.g. cyclic tab complete)
ln -f -s ~/.dotfiles/inputrc ~/.inputrc

# some terminals look for a .bash_profile. our
# .bash_profile is just a wrapper on bashrc
ln -f -s ~/.dotfiles/bash_profile ~/.bash_profile

# todo: comment & clean
ln -s ~/.dotfiles/bashrc ~/.bashrc
