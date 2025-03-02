# dotfiles

## Requirements

* Mac
    * System Settings
        * Privacy & Security
            * Full Disk Access
                * Enable terminal applications
* 1Password
    * Settings
        * Security
            * Unlock (recommended)
                * Windows Hello
                * Touch ID
        * Developer
            * Enable 1Password Developer
            * Enable 1Password SSH Agent
            * Enable 1Password CLI
            * Enable 1Password Developer Watchtower

## Install dependencies

### windows

start + r = pwsh

```powershell
winget install -e --id Microsoft.PowerShell

Start-Process pwsh -verb runas; if ($?) { exit }

winget install -e --id AgileBits.1Password.CLI
winget install -e --id GitHub.cli
winget install -e --id twpayne.chezmoi

. $PROFILE

op signin
op item get "GitHub Personal Access Token" --vault Personal --fields label=token --reveal | Out-String | gh auth login --hostname GitHub.com --git-protocol HTTPS --with-token
gh auth status

chezmoi init fumimaron9/dotfiles
chezmoi doctor
```

### darwin

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

eval $(/opt/homebrew/bin/brew shellenv)

brew install gcc unzip
brew doctor

brew install --cask 1password-cli
brew install gh
brew install chezmoi

cd ~
op plugin init gh

chezmoi init fumimaron9/dotfiles
chezmoi doctor
```

### linux

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

brew install gcc unzip
brew doctor

brew install --cask 1password-cli
brew install gh
brew install chezmoi

alias op="/mnt/c/Users/fumimaron9/AppData/Local/Microsoft/WinGet/Links/op.exe"

cd ~
op plugin init gh

chezmoi init fumimaron9/dotfiles
chezmoi doctor
```

## Setup dotfiles

```bash
chezmoi data
chezmoi --verbose --dry-run apply
chezmoi apply

git remote set-url origin $(git config --get remote.origin.url | sed -e "s/https:\/\/github\.com\//git@github.com:/g")
git remote set-url origin $(git config --get remote.origin.url | sed -e "s/git@github.com:/https:\/\/github\.com\//g")

exit
```

restart shell

```bash
lefthook install

mise doctor
mise install

# Not for windows
q doctor
```

## Operation winget

### upgrade

```powershell
winget list --upgrade-available
sudo.exe winget upgrade --all
```

## Operation brew

### upgrade

```bash
brew upgrade
brew cleanup
brew list
```

## Operation chezmoi

### sync

```bash
chezmoi status
chezmoi update

chezmoi diff
chezmoi apply
```

### edit

```bash
chezmoi edit
chezmoi diff
chezmoi apply

chezmoi cd
git add .
git commit -me
git push
```

### re-run run_once_ scripts

```bash
chezmoi state delete-bucket --bucket=scriptState
```

### testing template

#### pwsh

```powershell
chezmoi execute-template '{{ .chezmoi.os }}'

Get-Content -Path ~/.local/share/chezmoi/home/.chezmoi.toml.tmpl | Out-String | chezmoi execute-template --init --promptString email=example@example.com
```

#### others

```bash
chezmoi execute-template '{{ .chezmoi.os }}'

chezmoi execute-template --init --promptString email=example@example.com < ~/.local/share/chezmoi/home/.chezmoi.toml.tmpl
```

## Operation sheldon

```bash
sheldon lock
sheldon lock --update
```

## Operation mise

```bash
mise upgrade
mise prune
mise ls
```

