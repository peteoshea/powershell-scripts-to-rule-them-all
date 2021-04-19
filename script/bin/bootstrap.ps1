Write-Output "`n==> Bootstrapping dependencies..."

# Setup path variables
$binPath = Split-Path -Path $PSCommandPath -Parent
$scriptPath = Split-Path -Path $binPath -Parent
$basePath = Split-Path -Path $scriptPath -Parent

# Install anything that requires admin priviledges
$packagesFilePath = "$basePath\chocolatey-packages"
$chocolateyPackages = Test-Path -Path "$packagesFilePath" -PathType Leaf
if ($chocolateyPackages) {
  & "$binPath\admin.ps1"
  if ($LastExitCode) {
    Write-Output "Admin script failed with exit code: $LastExitCode"
    Exit $LastExitCode
  }
}

function Install-WinGetPackage {
  param (
    [Parameter(Mandatory = $true)]
    [string]
    $Name
  )
  Write-Output "===> Installing '$Name' using winget"
  # Enforce use of exact package name as name matching can cause issues if multiple matches found
  winget install $Name --exact
}

# Install any required winget packages
$packagesFilePath = "$basePath\winget-packages"
if (Test-Path -Path "$packagesFilePath" -PathType Leaf) {
  Write-Output "`n==> Installing winget packages..."
  $packageList = Get-Content -Path "$packagesFilePath"
  if ($packageList.Count -eq 1) {
    # A single item is treated as a string not an array
    Install-WinGetPackage -Name $packageList
  } else {
    For ($index = 0; $index -lt $packageList.Count; $index++) {
      $package = $packageList[$index];
      Install-WinGetPackage -Name $package
    }
  }
}
