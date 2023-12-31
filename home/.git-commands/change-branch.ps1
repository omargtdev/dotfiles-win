# Change to branch (local or remote)

($currentBranch = git rev-parse --abbrev-ref HEAD) 2> $null 1> $null

if ($null -eq $currentBranch) {
    Write-Log -Message 'It seems you are not in a repository.' -Type Error
    return
}

$branchToChange = $args[0]

if ($null -eq $branchToChange) {
    Write-Log -Message 'Give a branch name.' -Type Error
    return
}

if ($branchToChange -eq $currentBranch) {
    Write-Log -Message "You are already in '$branchToChange' branch." -Type Error
    return
}

$branchList = git branch

foreach ($branch in $branchList) {
    $branch = $branch.Trim()
    if ($branch.StartsWith('*')) {
        continue
    }

    if ($branch -eq $branchToChange) {
        git checkout $branchToChange
        Write-Log -Message 'Done!' -Type Success
        return
    }
}

# Try to get from origin
Write-Log -Message "Branch '$branchToChange' not found, trying to get from origin." -Type Info

git fetch origin $branchToChange

if ($LASTEXITCODE -ne 0) {
    Write-Log -Message "The branch '$branchToChange' was not found from origin." -Type Error
    return
}

git switch -c $branchToChange "origin/$branchToChange"
Write-Log -Message 'Done!' -Type Success
