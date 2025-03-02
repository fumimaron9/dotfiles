#!/usr/bin/env bash -eu

if [ ! -d "$DOTFILES_PATH" ]; then
  echo "ERROR: $DOTFILES_PATH does not exist."
  exit 1
fi

cd "$DOTFILES_PATH"

find "$DOTFILES_PATH/.config" -maxdepth 1 -mindepth 1 | xargs -I% ln -snfv % "$XDG_CONFIG_HOME"

for file in .??*; do
  [ "$file" = ".git" ] && continue
  [ "$file" = ".gitignore" ] && continue
  [ "$file" = ".gitattributes" ] && continue
  [ "$file" = ".github" ] && continue
  [ "$file" = ".DS_Store" ] && continue
  [ "$file" = ".editorconfig" ] && continue
  ln -snfv "$DOTFILES_PATH/$file" "$HOME/$file"
done
