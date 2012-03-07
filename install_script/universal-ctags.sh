#!/bin/bash -e

umask 022

mkdir -p $HOME/local/src

cd $HOME/local/src/
curl -sSfkLO https://github.com/universal-ctags/ctags/archive/master.tar.gz
tar xvfz master.tar.gz

cd ctags-master
./autogen.sh
./configure --prefix=$HOME/local --enable-iconv
make && make install
