#!/bin/bash -e

umask 022

mkdir -p $HOME/local/src
mkdir -p $HOME/local/bin
mkdir -p $HOME/local/share/zsh/site-functions

cd $HOME/local/src/
curl -sSfkLO http://downloads.sourceforge.net/project/zsh/zsh/5.2/zsh-5.2.tar.gz
tar xvfz zsh-5.2.tar.gz

cd zsh-5.2/

./configure \
--enable-multibyte \
--prefix=$HOME/local

make && make install


### zsh-completion
cd $HOME/local/src/
curl -sSfkL -o zsh-completions-0.25.0.tar.gz https://github.com/zsh-users/zsh-completions/archive/0.25.0.tar.gz
tar xvfz zsh-completions-0.25.0.tar.gz

cp -rp zsh-completions-0.25.0/src/* $HOME/local/share/zsh/site-functions/
