mise activate pwsh | Out-String | Invoke-Expression

Invoke-Expression (&starship init powershell)

Set-Alias vi nvim
Set-Alias ll ls
Set-Alias l ls

Set-Item Env:Path $Env:Path";C:\Program Files\LLVM\bin"
