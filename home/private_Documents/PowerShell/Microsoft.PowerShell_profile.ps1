$env:EDITOR = "nvim"

mise activate pwsh | Out-String | Invoke-Expression

#Set-Alias -Name l -Value ls
#Set-Alias -Name ll -Value ls
Set-Alias -Name l -Value lsd
function ll { lsd -la $args }
function lt { lsd --tree $args }
function tree { lsd --tree $args }

Set-Alias -Name vi -Value nvim

Invoke-Expression (&starship init powershell)
