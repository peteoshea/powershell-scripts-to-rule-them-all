# Check if Chocolatey is already installed
$installed = $false
if (Get-Command choco.exe -ErrorAction SilentlyContinue) {
    $installed = $true
}
if ($installed -eq $false) {
    Write-Host "==> Installing Chocolatey..."

    # Download and save installation script
    $url = 'https://chocolatey.org/install.ps1'
    $outPath = "$env:temp\installChocolatey.ps1"
    Invoke-WebRequest -UseBasicParsing -Uri $url -OutFile $outPath

    # Test signature
    $result = Get-AuthenticodeSignature -FilePath $outPath
    if ($result.Status -ne 'Valid')
    {
        Write-Warning "Installation Script Damaged/Malware?"
        Exit 1
    }

    # Run the installion script
    & "$outPath"

    # Tidy up
    Remove-Item -Path $outPath
} else {
    Write-Host "==> Updating Chocolatey..."
    choco upgrade chocolatey
}
