#!/bin/bash -e

umask 022

mkdir -p $HOME/local/src
mkdir -p $HOME/local/bin

cd $HOME/local/src/
curl -sSfkLO https://github.com/vim/vim/archive/master.tar.gz
tar zxvf master.tar.gz
cd vim-master

./configure \
--prefix=$HOME/local \
--with-python3-config-dir=$HOME/local/lib/python3.6/config-3.6m-x86_64-linux-gnu \
--enable-python3interp vi_cv_path_python3=$HOME/local/bin/python3.6 \
--with-lua-prefix=$HOME/local \
--enable-luainterp \
--with-features=huge \
--with-luajit \
--enable-multibyte \
--enable-xim \
--enable-fontset \
--enable-cscope \
--disable-gui \
--disable-selinux \
--enable-fail-if-missing

make && make install
