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
function Install-ChocolateyPackage {
    param ([string]$Name)
    Write-Host "===> Installing '$Name'"
}

$packagesFilePath = "$basePath\chocolatey-packages"
if (Test-Path -Path "$packagesFilePath" -PathType Leaf) {
    Write-Host "==> Installing Chocolatey packages..."
    $packageList = Get-Content -Path "$packagesFilePath"
    if ($packageList.Count -eq 1) {
        # A single item is treated as a string not an array
        Install-ChocolateyPackage -Name $packageList
    } else {
        For ($index = 0; $index -lt $packageList.Count; $index++) {
            $package = $packageList[$index];
            Install-ChocolateyPackage -Name $package
        }
    }
}
