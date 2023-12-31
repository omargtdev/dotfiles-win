if (Get-Command nvim.exe -ErrorAction SilentlyContinue | Test-Path) {
    Set-Alias v nvim
}

Set-Alias e explorer.exe
Set-Alias nt notepad.exe

if (Get-Command rg.exe -ErrorAction SilentlyContinue | Test-Path) {
    Set-Alias grep rg
} else {
    Set-Alias grep Select-String
}

Set-Alias touch New-Item

Remove-Alias pwd -ErrorAction SilentlyContinue
${function:pwd} = { (Get-Location).Path }

${function:whereis} = {
    $commandName = $args[0]
    if ($commandName -eq $null) {
        return
    }

    $path = Get-Command $commandName -ErrorAction SilentlyContinue
    if ($path -eq $null) {
        return
    }

    $path.Source -eq [string]::Empty `
        ? $path `
        : $path.Source
}

${function:gtr} = {
    # Go to ~/repos/$context folder
    $context = $args[0]
    if ($context -eq $null) {
        Write-Error -Message 'You need to provide the repo context.' -ErrorAction Stop
    }

    $baseDir = Join-Path $HOME 'repos'
    if (!([System.IO.Directory]::Exists($baseDir))) {
        New-Item -ItemType Directory -Path $baseDir
    }

    $targetDir = Join-Path $baseDir $context
    if (!([System.IO.Directory]::Exists($targetDir))) {
        Write-Error -Message 'The context (directory) that you have provided, does not exist.' -ErrorAction Stop
    }

    Set-Location $targetDir
}
