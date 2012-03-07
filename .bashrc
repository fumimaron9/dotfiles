export SHELL=`which bash`

if shopt | grep 'direxpand' > /dev/null 2>&1; then
  shopt -s direxpand
fi

if shopt | grep 'globstar' > /dev/null 2>&1; then
  shopt -s globstar
fi

dev_servers=("ubuntu" "oshiete-02-dev-web-001")

dev=0
for dev_server in ${dev_servers[@]}; do
if [ "${HOSTNAME}" == "${dev_server}" ]; then
  dev=1
  break
fi
done


#export PROMPT_COMMAND='__git_ps1 "\[\033[1;31m\]\u@\h\[\e[00m\] \[\e[1;34m\]\w\[\e[00m\]" " \$ "'
export PROMPT_COMMAND='__git_ps1 "\[\033[1;36m\]\u@\h\[\e[00m\] \[\e[1;34m\]\w\[\e[00m\]" " \$ "'

#export PS1='\[\e[01;31m\]\u@\h\[\e[00m\] \[\e[01;34m\]\w\[\e[00m\] \$ '
export PS1='\[\e[01;36m\]\u@\h\[\e[00m\] \[\e[01;34m\]\w\[\e[00m\] \$ '

# PROMPT_COMMAND
# example:
#   export PROMPT_COMMAND='__git_ps1 "\u@\h:\w" " \$ "'
#
# user: \u
# host: \h
# dir:  \w
#
# color
# red:    \[\033[1;31m\]
# blue:   \[\033[1;36m\]
# kaizyo: \[\e[00m\]


#if [ ${dev} -eq 1 ]; then
#  export PROMPT_COMMAND='__git_ps1 "\[\033[1;36m\]\u@\h\[\e[00m\] \[\e[1;34m\]\w\[\e[00m\]" " \$ "'
#  export PS1='\[\e[01;36m\]\u@\h\[\e[00m\] \[\e[01;34m\]\w\[\e[00m\] \$ '
#fi






if [ -f "$(brew --prefix)/etc/bash_completion" ]; then
  source "$(brew --prefix)/etc/bash_completion"
elif [ -f "$HOME/local/share/bash-completion/bash_completion" ]; then
  source "$HOME/local/share/bash-completion/bash_completion"
elif [ -f "/etc/bash_completion" ]; then
  source "/etc/bash_completion"
else
  echo "bash_completion is not supported"
fi


if [ -f "$(brew --prefix)/etc/bash_completion.d/git-completion.bash" ]; then
  source "$(brew --prefix)/etc/bash_completion.d/git-completion.bash"
elif [ -f "$HOME/local/share/doc/git-core/contrib/completion/git-completion.bash" ]; then
  source "$HOME/local/share/doc/git-core/contrib/completion/git-completion.bash"
elif [ -f "/usr/share/doc/git-$(git version | cut -d' ' -f3)/contrib/completion/git-completion.bash" ]; then
  source "/usr/share/doc/git-$(git version | cut -d' ' -f3)/contrib/completion/git-completion.bash"
else
  echo "git-completion is not supported"
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
