#!/bin/sh
set -eu

cd "$HOME"

command -v mise >/dev/null 2>&1 || exit 0

mise install
