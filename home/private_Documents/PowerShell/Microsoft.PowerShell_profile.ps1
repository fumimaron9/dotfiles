mise activate pwsh | Out-String | Invoke-Expression

Set-Alias vi nvim
Set-Alias ll ls
Set-Alias l ls

Invoke-Expression (&starship init powershell)
