Write-Output "`n==> Ensuring everything is up to date for this project..."

# Run bootstrap script to resolve dependencies
$scriptPath = Split-Path -Path $PSCommandPath -Parent
& "$scriptPath\bin\bootstrap.ps1"
if ($LastExitCode) {
  Write-Output "Bootstrap failed with exit code: $LastExitCode"
  Exit $LastExitCode
}

Write-Output "`n==> You are now ready to go!`n"
