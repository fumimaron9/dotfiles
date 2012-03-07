#!/usr/bin/env bash -e

umask 0022

xcode-select -p 1>/dev/null

if [ $? -ne 0 ]; then
  xcode-select --install
  exit
fi

DOTFILES_PATH=$HOME/dotfiles

if [ ! -d "$DOTFILES_PATH" ]; then
  git clone https://github.com/fumimaron9/dotfiles.git "$DOTFILES_PATH"
else
  echo "INFO: doffiles already exists."
  echo
fi

. $DOTFILES_PATH/.commonrc

cd "$DOTFILES_PATH"

# change ssh protocol
git remote set-url origin $(git config --get remote.origin.url | sed -e "s/https:\/\/github\.com\//git@github.com:/g")

# make directory
mkdir -p "$XDG_CONFIG_HOME"
mkdir -p "$XDG_CACHE_HOME"
mkdir -p "$XDG_DATA_HOME"

# install homebrew
if [ ! $(command -v brew) ]; then
  if [ "$(uname)" = "Darwin" ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    echo

    . $DOTFILES_PATH/scripts/setup_darwin.sh
    echo
  elif [ $(uname -r | grep -i "microsoft") ]; then
    sudo apt update
    sudo apt install linuxbrew-wrapper
    eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
    echo
  elif [ "$(uname)" = "Linux" ] && [ ! $(uname -r | grep -i "microsoft") ]; then
    git clone https://github.com/Homebrew/brew $HOME/.linuxbrew/Homebrew
    mkdir $HOME/.linuxbrew/bin
    ln -s $HOME/.linuxbrew/Homebrew/bin/brew $HOME/.linuxbrew/bin
    eval $($HOME/.linuxbrew/bin/brew shellenv)
    echo
  else
    echo "ERROR: Unknown OS"
    exit 1
  fi
fi

# install zinit
if [ ! -d "$HOME/.zinit" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"
  echo
fi

# brew install
brew bundle
echo

if [ -z "$(cat /etc/shells | grep `brew --prefix`/bin/zsh)" ]; then
  echo "$(brew --prefix)/bin/zsh" | sudo tee -a /etc/shells
  echo
fi

if [ "$SHELL" != "$(brew --prefix)/bin/zsh" ] && [ -z "$GITHUB_ACTIONS" ]; then
  chsh -s "$(brew --prefix)/bin/zsh"
  echo
fi

. $DOTFILES_PATH/scripts/configuration.sh
echo

. $DOTFILES_PATH/scripts/deploy.sh
echo

# gpg
mkdir -p "$HOME/.gnupg" && chmod 700 "$HOME/.gnupg"
echo "pinentry-program $(brew --prefix)/bin/pinentry-mac" > $HOME/.gnupg/gpg-agent.conf

# workspace
mkdir -p "$HOME/workspace"

echo "INFO: Please re-login"
