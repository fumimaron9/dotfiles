#!/usr/bin/env bash -eu

source $HOME/.zprofile

set +e
brew doctor
set -e

zinit report
