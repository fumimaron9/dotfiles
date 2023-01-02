#!/bin/bash -e

# yum install install build-essential libevent-devel libncurses5-devel

umask 022

mkdir -p $HOME/local/src

cd $HOME/local/src/
curl -sSfkLO https://github.com/tmux/tmux/releases/download/2.5/tmux-2.5.tar.gz
tar xzvf tmux-2.5.tar.gz

cd tmux-2.5

PKG_CONFIG_PATH="$HOME/local/lib/pkgconfig" ./configure \
--prefix=$HOME/local

make && make install
