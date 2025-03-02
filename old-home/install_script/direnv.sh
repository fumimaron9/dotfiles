#!/bin/bash -e

umask 022

mkdir -p $HOME/local/src
mkdir -p $HOME/local/bin

### m4
cd $HOME/local/src/

if [ "$(uname)" == 'Darwin' ]; then
  curl -sSfkLO https://github.com/direnv/direnv/releases/download/v2.10.0/direnv.darwin-amd64
  cp direnv.darwin-amd64 $HOME/local/bin/direnv
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
  curl -sSfkLO https://github.com/direnv/direnv/releases/download/v2.10.0/direnv.linux-amd64
  cp direnv.linux-amd64 $HOME/local/bin/direnv
else
  echo "Your platform ($(uname -a)) is not supported."
  exit 1
fi

chmod +x $HOME/local/bin/direnv
exec $SHELL -l
