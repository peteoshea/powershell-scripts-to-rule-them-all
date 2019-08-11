# Setup path variables
$binPath = Split-Path -Path $PSCommandPath -Parent
$scriptPath = Split-Path -Path $binPath -Parent
$basePath = Split-Path -Path $scriptPath -Parent

# Ensure Chocolatey is setup
& "$binPath\InstallChocolatey.ps1"
if ($LastExitCode) {
    Write-Host "Install/upgrade of Chocolatey failed with exit code: $LastExitCode"
    Exit $LastExitCode
}

# Install required packages
$packagesFilePath = "$basePath\chocolatey-packages"
if (Test-Path -Path "$packagesFilePath" -PathType Leaf) {
    Write-Host "==> Installing Chocolatey packages..."
    $packageList = Get-Content -Path "$packagesFilePath"
    For ($index = 0; $index -lt $packageList.Count; $index++) {
        $package = $packageList[$index];
        Write-Host "===> Installing '$package'"
    }
}
