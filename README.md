dotfiles
========

git@github.com:fumimaron9/dotfiles.git
cd dotfiles
sh init.sh








vim php
shift + k = open manual

mkdir -p $HOME/local/{src,man}
cd $HOME/local/src
curl -kLO http://us3.php.net/distributions/manual/php_manual_en.tar.gz
tar -zxvf php_manual_en.tar.gz -C $HOME/local/man
