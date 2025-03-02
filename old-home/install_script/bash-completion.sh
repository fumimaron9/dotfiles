#!/bin/bash -e

umask 022

mkdir -p $HOME/local/src

### bash-completion
cd $HOME/local/src/
curl -sSfkLO https://github.com/scop/bash-completion/archive/2.5.tar.gz
tar xfzv 2.5.tar.gz

cd bash-completion-2.5
autoreconf -i
./configure --prefix=$HOME/local
make && make install
