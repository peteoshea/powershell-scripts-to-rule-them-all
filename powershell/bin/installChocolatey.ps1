# Check if Chocolatey is already installed
$installed = $false
if (Get-Command choco -ErrorAction SilentlyContinue) {
    $installed = $true
}
if ($installed -eq $false) {
    Write-Host "==> Installing Chocolatey..."

    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}
else {
    Write-Host "==> Updating Chocolatey..."
    choco upgrade chocolatey
}
