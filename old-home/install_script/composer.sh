#!/bin/bash -e

umask 022

mkdir -p $HOME/local/src
mkdir -p $HOME/local/bin

cd $HOME/local/src
curl -sS https://getcomposer.org/installer | php
cp composer.phar $HOME/local/bin/composer

exec $SHELL -l
