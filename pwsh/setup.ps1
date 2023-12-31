# Setup powershell configuration

$baseDir = Split-Path -Parent $PROFILE

Copy-Item -Path *.ps1 -Exclude setup.ps1 -Destination $baseDir
Copy-Item -Path ./custom_functions -Recurse -Force -Destination $baseDir
