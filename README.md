dotfiles
========

## old

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/fumimaron9/dotfiles/master/bootstrap.sh)"
```

## chezmoi

### initial

```bash
chezmoi doctor

chezmoi init fumimaron9/dotfiles

chezmoi data
```

### pull repository

```bash
chezmoi status
chezmoi update
```

### testing template

```bash
chezmoi execute-template '{{ .chezmoi.os}}'

chezmoi execute-template < ~/.local/share/chezmoi/home/.chezmoi.toml.tmpl
```

```powershell
chezmoi execute-template '{{ .chezmoi.os}}'

Get-Content -Path ~/.local/share/chezmoi/home/.chezmoi.toml.tmpl | Out-String | chezmoi execute-template --init --promptString email=example@example.com
```
