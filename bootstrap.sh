#!/usr/bin/env sh

endpath="$HOME/.pirate-vim"

warn() {
    echo "$1" >&2
}

die() {
    warn "$1"
    exit 1
}

lnif() {
    if [ ! -e $2 ] ; then
        ln -s $1 $2
    fi
    if [ -L $2 ] ; then
        ln -sf $1 $2
    fi
}

echo "Yar we be swabbing the deck of your brand new pirate vim"

# Backup existing .vim stuff
echo "Stowing your old booty to make room for the new"
today=`date +%Y%m%d`
for i in $HOME/.vim $HOME/.vimrc $HOME/.gvimrc; do [ -e $i ] && [ ! -L $i ] && mv $i $i.$today; done


if [ ! -e $endpath/.git ]; then
    echo "What's got two eyes, two left feet, and two hooks?"
    echo "A pirate and his clone! yaaR"
    git clone --recursive git://github.com/vito-c/pirate-vim.git $endpath
else
    echo "Hoist the main sail and Pull up the achor"
    cd $endpath && git pull
fi


echo "To the High Seeea-links"
lnif $endpath/vimrc $HOME/.vimrc
lnif $endpath/gitconfig $HOME/.gitconfig
lnif $endpath/inputrc $HOME/.inputrc
lnif $endpath/vimrc.fork $HOME/.vimrc.fork
lnif $endpath/vimrc.bundles $HOME/.vimrc.bundles
lnif $endpath/vimrc.bundles.fork $HOME/.vimrc.bundles.fork
lnif $endpath/vim $HOME/.vim
if [ ! -d $endpath/vim/bundle ]; then
    mkdir -p $endpath/vim/bundle
fi

if [ ! -e $HOME/.vim/bundle/vundle ]; then
    echo "Bundles of booty"
    git clone http://github.com/gmarik/vundle.git $HOME/.vim/bundle/vundle
fi

echo "bundles of vundles"
system_shell=$SHELL
export SHELL="/bin/sh"
vim -u $endpath/vimrc.bundles +BundleInstall! +BundleClean +qall
export SHELL=$system_shell
