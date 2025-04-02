# Setup powershell configuration

$baseDir = Split-Path -Parent $PROFILE

if (-Not (Test-Path -Path $baseDir)) {
    mkdir $baseDir
}

Copy-Item -Path *.ps1 -Exclude setup.ps1 -Destination $baseDir
Copy-Item -Path ./temp_scripts -Recurse -Force -Destination $baseDir
