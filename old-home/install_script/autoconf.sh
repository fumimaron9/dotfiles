#!/bin/bash -e

umask 022

mkdir -p $HOME/local/src

### m4
cd $HOME/local/src/
curl -sSfkLO http://ftp.gnu.org/gnu/m4/m4-1.4.17.tar.gz
tar xvfz m4-1.4.17.tar.gz

cd m4-1.4.17/
./configure  --prefix=$HOME/local
make && make install

### autoconf
cd $HOME/local/src/
curl -sSfkLO http://ftp.gnu.org/gnu/autoconf/autoconf-2.69.tar.gz
tar xvfz autoconf-2.69.tar.gz

cd autoconf-2.69/
./configure  --prefix=$HOME/local
make && make install

