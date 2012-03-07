source $HOME/.commonrc
source $HOME/.commonalias

if [[ "$(uname)" == "Darwin" ]]; then
  LOGIN_SHELL=/usr/local/bin/bash
else
  LOGIN_SHELL=/home/linuxbrew/.linuxbrew/bin/bash
fi

[[ $SHELL != "/bin/bash" ]] && source $HOME/.bashrc

([[ $SHELL = "/bin/bash" ]] && export SHELL=$LOGIN_SHELL && exec $SHELL -l) && exit

# bashrc
#which zsh 1>/dev/null 2>&1 || source $HOME/.bashrc

# change zsh and exit is server exit
#([ -n "$SSH_TTY" ] && which zsh 1>/dev/null 2>&1 && exec zsh -l) && exit
#(which zsh 1>/dev/null 2>&1 && exec zsh -l) && exit
