$PSDefaultParameterValues['*:Encoding'] = 'utf8'
$env:EDITOR = "nvim"

Import-Module PSReadline

$PSReadLineOptions = @{
  EditMode = "Vi"
  BellStyle = "None"
  PredictionSource = "History"
  HistorySearchCursorMovesToEnd = $true
  AddToHistoryHandler = {
    param($line)
    $line -notmatch '(^\s+|^rm|^Remove-Item|fl|exit|^function$)'
  }
}
Set-PSReadLineOption @PSReadLineOptions

Set-PSReadLineKeyHandler -ViMode Insert -Chord Backspace -Function BackwardDeleteChar

Set-PSReadLineKeyHandler -ViMode Insert -Chord Ctrl+a -Function BeginningOfLine
Set-PSReadLineKeyHandler -ViMode Insert -Chord Ctrl+b -Function BackwardChar
Set-PSReadLineKeyHandler -ViMode Insert -Chord Ctrl+c -Function CancelLine
Remove-PSReadLineKeyHandler -ViMode Insert -Chord Ctrl+d
Set-PSReadLineKeyHandler -ViMode Insert -Chord Ctrl+e -Function EndOfLine
Set-PSReadLineKeyHandler -ViMode Insert -Chord Ctrl+f -Function ForwardChar
Set-PSReadLineKeyHandler -ViMode Insert -Chord Ctrl+g -Function Abort
Set-PSReadLineKeyHandler -ViMode Insert -Chord Ctrl+h -Function BackwardDeleteChar
# Remove-PSReadLineKeyHandler -ViMode Insert -Chord Ctrl+i
# Remove-PSReadLineKeyHandler -ViMode Insert -Chord Ctrl+j
Set-PSReadLineKeyHandler -ViMode Insert -Chord Ctrl+k -Function KillLine
Set-PSReadLineKeyHandler -ViMode Insert -Chord Ctrl+l -Function ClearScreen
# Remove-PSReadLineKeyHandler -ViMode Insert -Chord Ctrl+m
Set-PSReadLineKeyHandler -ViMode Insert -Chord Ctrl+n -Function NextHistory
# Remove-PSReadLineKeyHandler -ViMode Insert -Chord Ctrl+o
Set-PSReadLineKeyHandler -ViMode Insert -Chord Ctrl+p -Function PreviousHistory
# Remove-PSReadLineKeyHandler -ViMode Insert -Chord Ctrl+q
Set-PSReadLineKeyHandler -ViMode Insert -Chord Ctrl+r -Function ReverseSearchHistory
Set-PSReadLineKeyHandler -ViMode Insert -Chord Ctrl+s -Function ForwardSearchHistory
Remove-PSReadLineKeyHandler -ViMode Insert -Chord Ctrl+t
Set-PSReadLineKeyHandler -ViMode Insert -Chord Ctrl+u -Function BackwardKillLine
Set-PSReadLineKeyHandler -ViMode Insert -Chord Ctrl+v -Function Paste
Set-PSReadLineKeyHandler -ViMode Insert -Chord Ctrl+w -Function BackwardKillWord
# Remove-PSReadLineKeyHandler -ViMode Insert -Chord Ctrl+x
Remove-PSReadLineKeyHandler -ViMode Insert -Chord Ctrl+y
Remove-PSReadLineKeyHandler -ViMode Insert -Chord Ctrl+z

Set-PSReadLineKeyHandler -ViMode Insert -Chord Ctrl+Shift+f -Function NextWord
Set-PSReadLineKeyHandler -ViMode Insert -Chord Ctrl+Shift+b -Function BackwardWord

Set-PSReadLineKeyHandler -ViMode Insert -Chord Tab -Function TabCompleteNext
Set-PSReadLineKeyHandler -ViMode Insert -Chord Tab -Function MenuComplete
Set-PSReadLineKeyHandler -ViMode Insert -Chord Shift+Tab -Function Complete

Import-Module git-completion
op completion powershell | Out-String | Invoke-Expression
chezmoi completion powershell | Out-String | Invoke-Expression
mise activate pwsh | Out-String | Invoke-Expression

Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider Ctrl+f -PSReadlineChordReverseHistory Ctrl+r

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

Invoke-Expression (&starship init powershell)
