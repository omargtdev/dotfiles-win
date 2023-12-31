function Get-ChildItemSorted() {
    param(
        [Parameter(Mandatory=$false)][string]$PlainOptions,
        [Parameter(Mandatory=$false)][int32]$ChildNumber
    )

    $command = "Get-ChildItem"
    if($PlainOptions) { $command += " " + $PlainOptions }
    $command += " | Sort-Object LastWriteTime -Descending "

    if($ChildNumber -gt 0){
        $command += "| Select-Object -First $ChildNumber"
    }

    Invoke-Expression $command
}

# Review this
function Reload-Env {
    # Reloading powershell Env, e.g with new installations of programs
    $Env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + [IO.Path]::PathSeparator + 
    		[System.Environment]::GetEnvironmentVariable("Path","User")
}


function Add-Path ([string] $newPath) {
    if (!(Test-Path -Path $newPath)) {
        Write-Error 'You need to provide a valid path.' -ErrorAction Stop
    }

    $Env:Path = $Env:Path + [IO.Path]::PathSeparator + $newPath
}

function Write-Log {
    param (
        [Parameter(Mandatory)]
        [string]$Message,

        [Parameter(Mandatory=$false)]
        [ValidateSet("Error", "Warning", "Success", "Info", ErrorMessage = "You need to provide a correct the type.")]
        [string]$Type
    )

    $currentDate = Get-Date -Format "MM/dd/yyyy HH:mm:ss"
    $color = 'White'
    $typeSelected = 'INFO'
    
    switch ($Type) {
        'Error' {
            $color = 'Red'
            $typeSelected = 'ERROR'
        }
        'Warning' {
            $color = 'Yellow'
            $typeSelected = 'WARNING'
        }
        'Success' {
            $color = 'Green'
            $typeSelected = 'SUCCESS'
        }
    }

    Write-Host -ForegroundColor $color -Message "[$typeSelected]::[$currentDate] - $Message"
}
