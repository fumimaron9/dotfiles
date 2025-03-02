#!/bin/bash -e

umask 022

mkdir -p $HOME/local/src

cd $HOME/local/src/
curl -sSfkLO http://www.lua.org/ftp/lua-5.3.3.tar.gz
tar xvfz lua-5.3.3.tar.gz

cd lua-5.3.3/
make linux
#make test
make install INSTALL_TOP=$HOME/local


### luagit
cd $HOME/local/src
curl -kLO http://luajit.org/download/LuaJIT-2.0.5.tar.gz
tar zxvf LuaJIT-2.0.5.tar.gz
cd LuaJIT-2.0.5
make
make install PREFIX=$HOME/local
