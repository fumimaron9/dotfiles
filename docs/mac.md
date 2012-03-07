# mac




icloudのiCloud driveにチェックし中のテキストエディタをオフ。
ディスプレイの解像度をMAXに。




まずはインストールに時間がかかるxcodeApp storeからインストール



# ドックを隠す設定。
cmd + option + d



ドックを整理する
Finder,laucnhpad,activity monitor,kinematic,iterm2,chrome,vscode,

defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock tilesize -int 50
defaults write com.apple.dock magnification -bool true




mkdir Workspace

Finderの環境設定：
ファインダーサイドバー整理




# keyboard repeat
defaults write -g InitialKeyRepeat -int 12
defaults write -g KeyRepeat -int 1



# mouse cursor speed
defaults write -g com.apple.trackpad.scaling 2
defaults write -g com.apple.mouse.scaling 7



# displayスリープまで10分
pmset -a displaysleep 10


# finder関係
defaults write com.apple.Finder FXPreferredViewStyle Nlsv
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder AppleShowAllFiles TRUE

defaults write com.apple.finder NewWindowTarget -string "PfLo" && \
  defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}"

killall Finder


#コンピュータ名、ローカルホスト名を変更。
scutil --set ComputerName "f9-macbook-pro-2016-01"
scutil --set LocalHostName "f9-macbook-pro-2016-01"

# ゲスト無効
defaults write /Library/Preferences/com.apple.loginwindow GuestEnabled -bool true



# スリープ、スクリーンセーバ復帰後すぐにパスワードを聞く
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0




環境設定：キーボード（タッチバーなしのみ）
　キーボード　修飾キーボタンを押し、Caps Lockをアクションなしに
　キーボード　F1, F2などのすべてのキーを標準のファンクションキーとして使用
　入力ソース　カタカタのチェックを外し日本語のみにする





環境設定：セキュリティとプライバシー
　一般　スリープとスクリーンセーバの解除にパスワードを要求　すぐにに変更



環境設定：デスクトップとスクリーンセーバ
　デスクトップ　pictureからアナの画像に。

環境設定：ユーザとグループ
　ユーザの画像を選択し、画像を好きなものに変更する。




環境設定：日付と時刻
　時計：日付を表示にチェック

■タスクメニュー
　バッテリーをクリックし、割合(%)を表示


defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.menuextra.battery ShowPercent -string "YES"
defaults write com.apple.menuextra.clock 'DateFormat' -string 'EEE d MMM HH:mm'
defaults write com.apple.screencapture type -string "png"
defaults write com.apple.Safari AutoFillPasswords -bool false



========================

※スリープは電源ぼたんを押す！！



App store
Displaysをインストールし解像度変更。
ディスプレイ、解像度を変更しNVRAMクリア
https://support.apple.com/ja-jp/HT204063












Chromeのプロファイル作成とログイン

############# chrome
newtab

create new style

#most-visited {
	display: none;
}

次で始まるURLに
https://www.google.co.jp/_/chrome/newtab?espv=2&ie=UTF-8

名前をnewtabで保存


JSON Viewerをchrome web storeからインストール


























下記からxcodeインストール後にターミナルを起動して。

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew --version
brew cask --version
brew tap caskroom/versions

brew config


brew outdated
brew cask info iterm2
brew cask search iterm2
brew cask list --versions


brew doctor

# 下記は何故書いたか不明
sudo chown fumimaron9.admin /usr/local/lib












brew cask install java iterm2 visual-studio-code

Iterm2で起動。
iterm2 のPrefencesでProfileを作成。
General -> Basics -> Name: main
Other Actions...: set as default main
Colors -> Color Presets: Solarized Dark
Text -> Text Rendering -> Draw bold text in bright colors: uncheck
Window -> Window Appearance -> Transparency -> bar right little
Keys -> Key Mappings -> + -> command + r ignore 
iterm2 再起動。



# Mac&iphone共にwlanに繋げ、詳細設定からローカル保管庫を有効にし、プライマリを同期する
# passwordの生成は16,4,4
# app storeからインストールに変更
brew cask install 1password

# menu barからログインを隠す
brew cask install skype

# 同期は自動入力、パスワード、Googleペイメントはしない
brew cask install google-chrome

brew cask install dropbox

# 
brew cask install visual-studio-code

# Preferences->Profiles
# solarizedのプロファイル作成しデフォルトに変更変更、カラーパレットをsolalizedに


Profiles → Text → "Draw bold text in bright colors" 外す
brew cask install iterm2


brew cask install java
brew cask install android-studio
brew cask install intellij-idea

brew cask install docker

brew cask install slack

brew cask install mysqlworkbench

brew cask install kindle














universal-ctags


```bash
brew install coreutils --with-gmp
brew install gnu-getopt
brew link gnu-getopt --force
brew install autoreconf
brew install openssl

brew install git

brew install bash
brew install bash-completion

brew install zsh --without-etcdir
brew install zsh-completions zsh-history-substring-search zsh-syntax-highlighting
compaudit | xargs chmod g-w

brew install powerline

brew install --powerline --vim-powerline ricty
cp /usr/local/Cellar/ricty/4.0.1/share/fonts/*.ttf ~/Library/Fonts/
fc-cache -vf


brew install vim --with-gettext --with-python3 --with-luajit 

brew install tmux --with-utf8proc

brew install httpie
brew install mosh




pip install -user powerline-status
pyenv rehash

brew install pyenv
pyenv install --list | grep anaconda
pyenv install anaconda3-4.0.0
pyenv global anaconda3-4.0.0
pyenv rehash


###### anaconda
http://qiita.com/y__sama/items/5b62d31cb7e6ed50f02c

conda update conda
conda info
conda env list
conda search python
conda create -n infra python=2.7
conda info -e
activate infra
deactivate
conda list
#conda remove -n infra --all


# condo searchででてこないものはできるらしが仮想環境では無理か？
conda skeleton pypi ansible
conda build ansible
conda install --use-local ansible
```


```bash
ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa -C "$(whoami)@$(hostname -s)"

公開鍵をgithubに設置。

ssh -T git@github.com
git clone git@github.com:fumimaron9/dotfiles.git
cd dotfiles
sh init.sh




Install docker & kinematic




################################# brew
# アップデートと不要なもの整理
brew update && brew upgrade
brew cask cleanup -n
brew cleanup -s && brew prune

# caskの強制アップデートらしい
brew cask install --force $(brew cask list)
```



```bash
############ docker
cd ~/
curl -kLO https://github.com/docker/for-mac/files/704055/slirp.zip
unzip slirp.zip
cp com.docker.slirp /Applications/Docker.app/Contents/MacOS/com.docker.slirp
# docker restart
```




brew cask install google-drive
brew cask install boostnote






