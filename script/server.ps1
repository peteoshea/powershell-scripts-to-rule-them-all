Write-Output "`n==> Launch the application..."

# Run update script to ensure everything is up to date
$scriptPath = Split-Path -Path $PSCommandPath -Parent
& "$scriptPath\update.ps1"
if ($LastExitCode) {
  Write-Output "Update failed with exit code: $LastExitCode"
  Exit $LastExitCode
}

Write-Output "`n==> Start the server..."
Write-Output "** Add commands to setup and then start your project here **"
