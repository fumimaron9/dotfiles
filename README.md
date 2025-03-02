# dotfiles

## Install dependencies

### windows

start + r = pwsh

```powershell
winget install --id Microsoft.Powershell --source winget

Start-Process pwsh -verb runas; if ($?) { exit }

winget install -e --id=twpayne.chezmoi
. $PROFILE
chezmoi doctor
```

### others

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
exec $SHELL -l
brew doctor

brew install chezmoi
exec $SHELL -l
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
mise doctor
mise install
mise ls

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
