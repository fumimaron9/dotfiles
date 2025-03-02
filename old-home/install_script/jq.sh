#!/bin/bash -e

umask 022

mkdir -p $HOME/local/bin

cd $HOME/local/bin/

curl -sSfkL -o jq https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64

chmod +x jq

