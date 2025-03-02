#!/usr/bin/env bash -e

umask 0022

if [ "$(uname)" = "Darwin" ]; then
  xcode-select -p 1>/dev/null
  if [ $? -ne 0 ]; then
    xcode-select --install
    exit
  fi
fi

DOTFILES_PATH=$HOME/dotfiles

if [ ! -d "$DOTFILES_PATH" ]; then
  git clone https://github.com/fumimaron9/dotfiles.git "$DOTFILES_PATH"

  # change ssh protocol
  git remote set-url origin $(git config --get remote.origin.url | sed -e "s/https:\/\/github\.com\//git@github.com:/g")
else
  echo "INFO: doffiles already exists."
  echo
fi

. $DOTFILES_PATH/.commonprofile

cd "$DOTFILES_PATH"

# xdg base directory
mkdir -p "$XDG_CONFIG_HOME"
mkdir -p "$XDG_CACHE_HOME"
mkdir -p "$XDG_DATA_HOME"

if [ ! $(command -v brew) ]; then
  if [ "$(uname)" = "Darwin" ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo
    . $DOTFILES_PATH/scripts/setup_darwin.sh
    echo

    if [ -z "$(cat /etc/shells | grep `brew --prefix zsh`/bin/zsh)" ]; then
      echo "$(brew --prefix zsh)/bin/zsh" | sudo tee -a /etc/shells
      echo
    fi

    if [ "$SHELL" != "$(brew --prefix zsh)/bin/zsh" ] && [ -z "$GITHUB_ACTIONS" ]; then
      chsh -s "$(brew --prefix zsh)/bin/zsh"
      echo
    fi
  elif [ "$(uname)" = "Linux" ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo
  else
    echo "ERROR: Unknown OS"
    exit 1
  fi
fi

if [ $(command -v brew) ]; then
  brew bundle
  brew cleanup
  #brew cleanup --prune=all
  echo
fi

. $DOTFILES_PATH/scripts/configuration.sh
echo

. $DOTFILES_PATH/deploy.sh
echo

# gpg
mkdir -p "$HOME/.gnupg" && chmod 700 "$HOME/.gnupg"
if [ "$(uname)" = "Darwin" ]; then
  echo "pinentry-program $(brew --prefix pinentry-mac)/bin/pinentry-mac" > $HOME/.gnupg/gpg-agent.conf
fi

# workspace
mkdir -p "$HOME/workspace"

echo "INFO: Please re-login"

