# Setup path variables
$binPath = Split-Path -Path $PSCommandPath -Parent
$scriptPath = Split-Path -Path $binPath -Parent
$basePath = Split-Path -Path $scriptPath -Parent

# There are multiple places to install a package so pull code into common function
function Install-ChocolateyPackage {
    param ([string]$Name)
    Write-Host "===> Installing '$Name'"
    choco upgrade $Name --confirm
}

# Install any required Chocolatey packages
$packagesFilePath = "$basePath\chocolatey-packages"
if (Test-Path -Path "$packagesFilePath" -PathType Leaf) {
    # Ensure Chocolatey is setup
    & "$binPath\installChocolatey.ps1"
    if ($LastExitCode) {
        Write-Host "Install/upgrade of Chocolatey failed with exit code: $LastExitCode"
        Exit $LastExitCode
    }

    Write-Host "==> Installing Chocolatey packages..."
    $packageList = Get-Content -Path "$packagesFilePath"
    if ($packageList.Count -eq 1) {
        # A single item is treated as a string not an array
        Install-ChocolateyPackage -Name $packageList
    }
    else {
        For ($index = 0; $index -lt $packageList.Count; $index++) {
            $package = $packageList[$index];
            Install-ChocolateyPackage -Name $package
        }
    }
}
