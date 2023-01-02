#!/bin/bash -e

umask 022

mkdir -p $HOME/local/src
mkdir -p $HOME/local/bin

cd $HOME/local/src
curl -sSfkLO https://github.com/monochromegane/the_platinum_searcher/releases/download/v1.7.8/pt_linux_amd64.tar.gz
tar xvfz pt_linux_amd64.tar.gz

chmod +x pt_linux_amd64/pt
cp pt_linux_amd64/pt $HOME/local/bin

