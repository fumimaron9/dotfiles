#!/bin/bash -e

umask 022

mkdir -p $HOME/local/src

cd $HOME/local/src/
curl -sSfkLO https://www.python.org/ftp/python/3.6.2/Python-3.6.2.tgz
tar xvfz Python-3.6.2.tgz

cd Python-3.6.2/
./configure --prefix=$HOME/local
make
make altinstall
