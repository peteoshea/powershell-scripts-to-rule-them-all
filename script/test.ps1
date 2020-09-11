param(
    [Parameter(Mandatory=$false, Position=0, ValueFromRemainingArguments,
    HelpMessage="Enter one or more specific tests")]
    [string[]]
    $Test
)

$scriptPath = Split-Path -Path $PSCommandPath -Parent

Write-Output "`n==> Running tests..."
Write-Output "Tests started at $(Get-Date)"

if ($PSBoundParameters.ContainsKey('Test')) {
    & "$basePath\bin\checkScripts.ps1" $Test
} else {
    & "$basePath\bin\checkScripts.ps1"
}
if ($LastExitCode) {
    Write-Output "checkScripts failed with exit code: $LastExitCode"
    Exit $LastExitCode
}

Write-Output "Tests finished at $(Get-Date)"
