#!/bin/bash -e

umask 022

mkdir -p $HOME/local/src
mkdir -p $HOME/local/bin

### m4
cd $HOME/local/src/

if [ "$(uname)" == 'Darwin' ]; then
  curl -sSfkLO https://releases.hashicorp.com/terraform/0.9.8/terraform_0.9.8_darwin_amd64.zip
  unzip terraform_0.9.8_darwin_amd64.zip
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
  curl -sSfkLO https://releases.hashicorp.com/terraform/0.9.8/terraform_0.9.8_linux_amd64.zip
  unzip terraform_0.9.8_linux_amd64.zip
else
  echo "Your platform ($(uname -a)) is not supported."
  exit 1
fi

mv terraform $HOME/local/bin
exec $SHELL -l
