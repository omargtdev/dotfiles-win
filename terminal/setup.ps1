# Setup windows terminal config

function Setup-HackNerdFont () {

    $fontsRegisterBase = 'HKCU:\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Fonts'

    function Check-ExistingFontByName ([string] $fontName) {
	Get-ItemProperty -Path $fontsRegisterBase -Name $fontName -ErrorAction SilentlyContinue
    }
    
    function Install-Font ([string] $fontPath, [string] $fontName) {
	New-ItemProperty $fontsRegisterBase -Name $fontName -PropertyType string -Value $fontPath | Out-Null
    }

    $bold = 'Bold'
    $boldItalic = 'BoldItalic'
    $italic = 'Italic'
    $regular = 'Regular'

    $boldFontExternalFile = "HackNerdFontMono-$bold.ttf"
    $boldItalicFontExternalFile = "HackNerdFontMono-$boldItalic.ttf"
    $italicFontExternalFile = "HackNerdFontMono-$italic.ttf"
    $regularFontExternalFile = "HackNerdFontMono-$regular.ttf"

    $boldFontName = 'Hack Nerd Font Mono Bold (TrueType)'
    $boldItalicFontName = 'Hack Nerd Font Mono Bold Italic (TrueType)'
    $italicFontName = 'Hack Nerd Font Mono Italic (TrueType)'
    $regularFontName = 'Hack Nerd Font Mono Regular (TrueType)'
	
    $baseTarget = 'https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/Hack'
    $baseTempDir = Join-Path $env:TEMP 'HackNerdFont'
    $fontsDir = Join-Path $env:LOCALAPPDATA 'Microsoft' 'Windows' 'Fonts'

    if ([System.IO.Directory]::Exists($baseTempDir)) {
        Remove-Item -Recurse $baseTempDir
    }
    New-Item -ItemType Directory -Path $baseTempDir | Out-Null

    # Bold Style
    if (!(Check-ExistingFontByName($boldFontName))) {
	Write-Host "[INFO]: Hack Bold was not found. Downloadig..."
        $boldTarget = "$baseTarget/$bold/$boldFontExternalFile"
	$tempFile = Join-Path $baseTempDir $boldFontExternalFile
	Invoke-WebRequest -Uri $boldTarget -OutFile $tempFile
	Copy-Item $tempFile $fontsDir

	$fontPath = Join-Path $fontsDir $boldFontExternalFile
	Write-Host "[INFO]: Installing Hack Bold font..."
	Install-Font $fontPath $boldFontName
	Write-Host "[INFO]: Hack Bold font was installed."
    }

    # Bold Italic Style
    if (!(Check-ExistingFontByName($boldItalicFontName))) {
	Write-Host "[INFO]: Hack Bold Italic was not found. Downloadig..."
    	$boldItalicTarget = "$baseTarget/$boldItalic/$boldItalicFontExternalFile"
	$tempFile = Join-Path $baseTempDir $boldItalicFontExternalFile
	Invoke-WebRequest -Uri $boldItalicTarget -OutFile $tempFile
	Copy-Item $tempFile $fontsDir

	$fontPath = Join-Path $fontsDir $boldItalicFontExternalFile
	Write-Host "[INFO]: Installing Hack Bold Italic font..."
	Install-Font $fontPath $boldItalicFontName
	Write-Host "[INFO]: Hack Bold Italic was installed."
    }

    # Italic Style
    if (!(Check-ExistingFontByName($italicFontName))) {
	Write-Host "[INFO]: Hack Italic was not found. Downloadig..."
        $italicTarget = "$baseTarget/$italic/$italicFontExternalFile"
	$tempFile = Join-Path $baseTempDir $italicFontExternalFile
	Invoke-WebRequest -Uri $italicTarget -OutFile $tempFile
	Copy-Item $tempFile $fontsDir

	Write-Host "[INFO]: Installing Hack Italic font..."
	$fontPath = Join-Path $fontsDir $italicFontExternalFile
	Install-Font $fontPath $italicFontName
	Write-Host "[INFO]: Hack Italic was installed."
    }

    # Regular Style
    if (!(Check-ExistingFontByName($regularFontName))) {
	Write-Host "[INFO]: Hack Regular was not found. Downloadig..."
	$regularTarget = "$baseTarget/$regular/$regularFontExternalFile"
	$tempFile = Join-Path $baseTempDir $regularFontExternalFile
	Invoke-WebRequest -Uri $regularTarget -OutFile $tempFile
	Copy-Item $tempFile $fontsDir
	
	Write-Host "[INFO]: Installing Hack Regular font..."
	$fontPath = Join-Path $fontsDir $regularFontExternalFile
	Install-Font $fontPath $regularFontName
	Write-Host "[INFO]: Hack Regular was installed."
    } 

    Remove-Item -Recurse $baseTempDir
}

$packageIdentifier = 'Microsoft.WindowsTerminal_8wekyb3d8bbwe'
$baseDir = Join-Path $env:LOCALAPPDATA 'Packages' $packageIdentifier 'LocalState'
$configFile = 'settings.json'

$target = Join-Path $baseDir $configFile

# Get hack nerd font
#Setup-HackNerdFont

# Backup
Write-Host "[INFO]: Making backup of current config."
$backupFile = "$target.bk"
Copy-Item $target $backupFile
Write-Host "[INFO]: Backup in $backupFile file."

Copy-Item ./settings.json $baseDir

Write-Host "[INFO]: Windows Terminal configuration done!"
