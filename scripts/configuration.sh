#!/usr/bin/env bash -eu

###
 # .ssh/config
 ##
if [ ! -d "$HOME/.ssh" ]; then
  mkdir -p $HOME/.ssh
  chmod 700 $HOME/.ssh
fi

if [ ! -f "$HOME/.ssh/config" ]; then
  tee $HOME/.ssh/config << EOF
Host *
  ForwardAgent yes
  ServerAliveInterval 60
  GSSAPIAuthentication no
EOF

  if [[ "$(uname)" == "Darwin" ]]; then
    tee -a $HOME/.ssh/config << EOF
  UseKeychain yes
  AddKeysToAgent yes
EOF
echo
fi

  tee -a $HOME/.ssh/config << EOF

# Host example
#   HostName dev-web
#   Port 22
#   User $USER
#   IdentityFile ~/.ssh/id_rsa
#   ProxyCommand ssh -A -i~/.ssh/id_rsa $USER@bastion -W %h:%p
#   LocalForward 80 dev-web:80
#   LocalForward 5432 postgresql.xxxxx.ap-northeast-1.rds.amazonaws.com:5432
EOF
echo
  chmod 600 $HOME/.ssh/config
fi

###
 # .my.cnf
 ##
if [ ! -f "$HOME/.my.cnf" ]; then
  tee $HOME/.my.cnf << EOF
[client]
#user=root
#password=fumimaron9
#host=127.0.0.1
#database=test
EOF
echo
fi
