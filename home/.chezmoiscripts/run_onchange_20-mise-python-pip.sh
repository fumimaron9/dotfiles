#!/bin/sh
set -eu

cd "$HOME"

REQ_FILE="$HOME/.config/python/global-requirements.txt"
MISE_CFG="$HOME/.config/mise/config.toml"

STATE_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/mise-global-python"
STATE_FILE="$STATE_DIR/python-version"

command -v mise >/dev/null 2>&1 || exit 0
[ -f "$REQ_FILE" ] || exit 0
[ -f "$MISE_CFG" ] || exit 0

mkdir -p "$STATE_DIR"

# mise が選ぶ "グローバル python" のバージョンを取得
PY_VER="$(mise exec -- python -c 'import sys; print(".".join(map(str, sys.version_info[:3])))')"

OLD_VER=""
[ -f "$STATE_FILE" ] && OLD_VER="$(cat "$STATE_FILE" || true)"

# Python バージョンが変わったら pip もアップグレードして入れ直す
if [ "$PY_VER" != "$OLD_VER" ]; then
  mise exec -- python -m pip install --upgrade pip
  echo "$PY_VER" > "$STATE_FILE"
fi

# requirements を同期（入ってなければ入る／バージョン差分も反映）
mise exec -- python -m pip install -r "$REQ_FILE"
