#!/bin/bash -e

umask 022

mkdir -p $HOME/local/src
mkdir -p $HOME/local/share/doc/git-core/contrib

# need autoconf 2.6.9
cd $HOME/local/src/
curl -sSfkL -o git-2.13.5.tar.gz https://github.com/git/git/archive/v2.13.5.tar.gz
tar xvfz git-2.13.5.tar.gz

cd git-2.13.5/
make configure

if [ $(cat /etc/redhat-release | grep "Red Hat Linux release 9") != "" ]; then
  CPPFLAGS="-I/usr/kerberos/include" ./configure --prefix=$HOME/local
else
  ./configure --prefix=$HOME/local
fi

make && make install

cp -rp contrib/* $HOME/local/share/doc/git-core/contrib/

make -C $HOME/local/share/doc/git-core/contrib/diff-highlight/
