param(
  [Parameter(Mandatory = $false, Position = 0, ValueFromRemainingArguments,
    HelpMessage = "Enter one or more specific tests")]
  [string[]]
  $Test
)

$scriptPath = Split-Path -Path $PSCommandPath -Parent

Write-Output "`n==> Start running tests at $(Get-Date)"

if ($PSBoundParameters.ContainsKey('Test')) {
  & "$scriptPath\bin\checkScripts.ps1" $Test
} else {
  & "$scriptPath\bin\checkScripts.ps1"
}

Write-Output "`n==> Script analysis finished at $(Get-Date)`n"

if ($LastExitCode) {
  Write-Output "checkScripts failed with exit code: $LastExitCode"
  Exit $LastExitCode
}

Write-Output "==> Tests finished at $(Get-Date)`n"
