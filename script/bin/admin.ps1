function Assert-Latest-PowerShell-Installed {
  $psCoreInstalled = $false
  if (Get-Command pwsh -ErrorAction SilentlyContinue) {
    $psCoreInstalled = $true
  }
  if ($psCoreInstalled -eq $false) {
    $psPackageName = "Microsoft.PowerShell"
    Write-Output "===> Installing '$psPackageName' using winget"
    winget install $psPackageName --exact
  }
}

# Check for Admininstrator permissions
if (([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
  Write-Output "Script is being run as Administrator"
} else {
  # Re-run the script using RunAs to elevate permissions
  Write-Warning "Script needs Administrator permissions so spawning elevated version"
  Start-Sleep 1
  Assert-Latest-PowerShell-Installed
  Start-Process pwsh "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs -Wait
  exit
}

# Setup path variables
$binPath = Split-Path -Path $PSCommandPath -Parent
$scriptPath = Split-Path -Path $binPath -Parent
$basePath = Split-Path -Path $scriptPath -Parent

# Ensure Chocolatey is setup
& "$binPath\installChocolatey.ps1"
if ($LastExitCode) {
  Write-Output "Install/upgrade of Chocolatey failed with exit code: $LastExitCode"
  Exit $LastExitCode
}

function Install-ChocolateyPackage {
  param (
    [Parameter(Mandatory = $true)]
    [string]
    $Name
  )
  Write-Output "===> Installing '$Name' using Chocolatey"
  choco upgrade $Name --confirm
}

# Install any required Chocolatey packages
$packagesFilePath = "$basePath\chocolatey-packages"
if (Test-Path -Path "$packagesFilePath" -PathType Leaf) {
  Write-Output "`n==> Installing Chocolatey packages..."
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

# Call Chocolatey script to apply changes to the current sessions environment
Update-SessionEnvironment

# Wait for user response in case this was spawned as a separate process
Read-Host -Prompt "`nPress <ENTER> to continue"
