$scriptPath = Split-Path -Path $PSCommandPath -Parent
& "$scriptPath\bin\bootstrap.ps1"
if ($LastExitCode) {
    Write-Host "Bootstrap failed with exit code: $LastExitCode"
    Exit $LastExitCode
}

Write-Host "`n==> App is now ready to go!`n"
