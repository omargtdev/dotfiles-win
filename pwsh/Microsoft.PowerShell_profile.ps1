# Start

$baseDir = Split-Path -Parent $PROFILE
Push-Location $baseDir

Get-ChildItem *.ps1 -Exclude Microsoft.PowerShell_profile.ps1 | `
    ForEach-Object -Process { Invoke-Expression ". '$_'" }

# Scripts that are temporary (use for work or another subject)
Add-Path $(Join-Path $baseDir 'temp_scripts')

Pop-Location

# Init oh-my-posh 
#oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/omargtdev.omp.json" | Invoke-Expression
