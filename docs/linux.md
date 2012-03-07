# linux

### office(inv)
sh bash-completion.sh

sh autoconf.sh
sh python.sh
sh lua.sh
sh vim.sh
sh universal-ctags.sh

sh git.sh
sh pt.sh
sh jq.sh

sh libevent.sh
sh tmux.sh


### cloud

exec office

sh zsh.sh

-----------------------------------------

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)" && sudo chown -R $USER: ~/.cache

exec $SHELL -l

brew install gcc
brew install git
brew install python
brew install python3
brew install ruby
brew install neovim
brew install zsh
brew install bash
brew install bash-completion
brew install zsh-completions zsh-history-substring-search zsh-syntax-highlighting
brew install tmux



$(brew --prefix)/bin/pip2.7 install neovim
$(brew --prefix)/bin/pip3.6 install neovim
$(brew --prefix)/bin/gem install neovim

brew tap universal-ctags/universal-ctags
brew install --HEAD universal-ctags



brew tap monochromegane/pt
brew install --HEAD pt







brew install jq
brew install httpie
brew install mosh





# linuxの場合は依存が多すぎてな上fontforgeが対応していないためやらない。
brew tap sanemat/font
brew install ricty --with-powerline


＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃　ここから
cp $(brew --prefix)/Cellar/ricty/4.0.1/share/fonts/*.ttf ~/Library/Fonts/
fc-cache -vf



