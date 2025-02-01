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

### testing template

```bash
chezmoi execute-template '{{ .chezmoi.os}}'

chezmoi execute-template < dot_zshrc.tmpl
```

```powershell
chezmoi execute-template '{{ .chezmoi.os}}'

Get-Content -Path ~/.local/share/chezmoi/home/.chezmoi.toml.tmpl | Out-String | chezmoi execute-template --init --promptString email=me@home.org
```
