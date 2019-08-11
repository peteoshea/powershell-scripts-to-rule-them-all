$BinPath = Split-Path -Path $PSCommandPath -Parent
& "$BinPath\InstallChocolatey.ps1"
if ($LastExitCode) {
    Write-Host "Install/upgrade of Chocolatey failed with exit code: $LastExitCode"
    Exit $LastExitCode
}
