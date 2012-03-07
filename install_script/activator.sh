#!/bin/bash -e

umask 022

mkdir -p $HOME/local/src
mkdir -p $HOME/local/bin

cd $HOME/local/src
curl -sSfkLO https://downloads.typesafe.com/typesafe-activator/1.3.9/typesafe-activator-1.3.9-minimal.zip
unzip typesafe-activator-1.3.9-minimal.zip

\cp activator-1.3.9-minimal/bin/activator $HOME/local/bin
\cp -rp activator-1.3.9-minimal/libexec $HOME/local

exec $SHELL -l
