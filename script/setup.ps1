$ScriptPath = Split-Path -Path $PSCommandPath -Parent
& "$ScriptPath\bin\bootstrap.ps1"
if ($LastExitCode) {
    Write-Host "Bootstrap failed with exit code: $LastExitCode"
    Exit $LastExitCode
}
