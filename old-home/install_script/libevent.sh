#!/bin/bash -e

umask 022

mkdir -p $HOME/local/src

cd $HOME/local/src/
curl -sSfkLO https://github.com/downloads/libevent/libevent/libevent-2.0.21-stable.tar.gz
tar xvfz libevent-2.0.21-stable.tar.gz

cd libevent-2.0.21-stable
./configure --prefix=$HOME/local
make && make install

