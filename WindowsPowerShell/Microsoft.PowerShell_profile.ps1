if(Test-Path Function:\Prompt) {Rename-Item Function:\Prompt PrePoshGitPrompt -Force}

# Load posh-git example profile
. 'C:\Tools\poshgit\dahlbyk-posh-git-fadc4dd\profile.example.ps1'

Rename-Item Function:\Prompt PoshGitPrompt -Force
function Prompt() {if(Test-Path Function:\PrePoshGitPrompt){++$global:poshScope; New-Item function:\script:Write-host -value "param([object] `$object, `$backgroundColor, `$foregroundColor, [switch] `$nonewline) " -Force | Out-Null;$private:p = PrePoshGitPrompt; if(--$global:poshScope -eq 0) {Remove-Item function:\Write-Host -Force}}PoshGitPrompt}

$GitPromptSettings.EnableFileStatus = $false



### setting git
#$env:PATH = "$env:ChocolateyInstall\lib\putty.portable.0.65\tools;" + $env:PATH
[Environment]::SetEnvironmentVariable("GIT_SSH", "PLINK.EXE", "User")
[Environment]::SetEnvironmentVariable("GYP_MSVS_VERSION", "2015", "User")
