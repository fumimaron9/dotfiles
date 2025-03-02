$PSDefaultParameterValues['*:Encoding'] = 'utf8'
$env:EDITOR = "nvim"

Import-Module PSReadline
Set-PSReadLineOption -EditMode Emacs
set-psreadlinekeyhandler -key tab -function tabcompletenext
Set-PSReadLineOption -BellStyle None
Set-PSReadLineOption -HistoryNoDuplicate
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -AddToHistoryHandler {
  param($line)
  $line -notmatch '(^\s+|^rm|^Remove-Item|fl|exit|^function$)'
}

op completion powershell | Out-String | Invoke-Expression

mise activate pwsh | Out-String | Invoke-Expression

function ehistory { nvim $HOME/AppData\Roaming\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt }

Set-Alias -Name l -Value lsd
function ll { lsd -l $args }
function lt { lsd --tree $args }
function tree { lsd --tree $args }

Set-Alias -Name vi -Value nvim

function which {
 Get-Command -Name $args[0] -ErrorAction SilentlyContinue |
 Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

Set-Alias -Name open -Value Invoke-Item

function batdiff {
  git diff --name-only --relative --diff-filter=d | ForEach-Object { bat --diff $_ }
}

Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

Invoke-Expression (&starship init powershell)
