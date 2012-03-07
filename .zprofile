export SHELL=`which zsh`
source $HOME/.commonrc
source $HOME/.commonalias

if [[ "$(uname)" == "Darwin" && "$(uname -m)" == "arm64" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if [ ! -d "$XDG_DATA_HOME/zinit" ]; then
  sh -c "$(curl -fsSL https://git.io/zinit-install)"
  echo
fi

