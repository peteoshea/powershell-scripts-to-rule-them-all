$scriptPath = Split-Path -Path $PSCommandPath -Parent
$basePath = Split-Path -Path $scriptPath -Parent

Write-Output "`n==> Running tests..."
Write-Output "Tests started at $(Get-Date)"

& "$basePath\checkScripts.ps1"
if ($LastExitCode) {
    Write-Output "checkScripts failed with exit code: $LastExitCode"
    Exit $LastExitCode
}

Write-Output "Tests finished at $(Get-Date)"
