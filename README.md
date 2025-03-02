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
winget install -e --id twpayne.chezmoi

. $PROFILE

op vault
chezmoi doctor
```

### others

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
exec $SHELL -l
brew doctor

brew install --cask 1password-cli
brew install chezmoi

exec $SHELL -l

op vault
chezmoi doctor
```

## Setup dotfiles

```bash
chezmoi init fumimaron9/dotfiles
chezmoi data
chezmoi --verbose --dry-run apply
chezmoi --verbose apply

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
sudo.exe winget upgrade --recurse
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
chezmoi --verbose apply
```

### edit

```bash
chezmoi edit
chezmoi diff
chezmoi --verbose apply

chezmoi cd
git add .
git commit -me
git push
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
