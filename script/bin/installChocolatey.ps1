[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingInvokeExpression', '', Justification = 'Recommended method from Chocolatey so supress this message for now')]
param()

# Check if Chocolatey is already installed
$installed = $false
if (Get-Command choco -ErrorAction SilentlyContinue) {
  $installed = $true
}
if ($installed -eq $false) {
  Write-Output "==> Installing Chocolatey..."

  Set-ExecutionPolicy Bypass -Scope Process -Force
  [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
  Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

  Write-Output "Configure ChocolateyInstall environment variable"
  $env:ChocolateyInstall = [System.Environment]::GetEnvironmentVariable("ChocolateyInstall", "Machine")
} else {
  Write-Output "==> Updating Chocolatey..."
  choco upgrade chocolatey
}

Write-Output "Import the PowerShell profile for Chocolatey"
Import-Module "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
