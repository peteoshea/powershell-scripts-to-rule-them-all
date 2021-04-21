param(
  [Parameter(Mandatory = $false, Position = 0, ValueFromRemainingArguments,
    HelpMessage = "Enter one or more specific tests")]
  [string[]]
  $Test
)

$errors = 0;
$warnings = 0;
$hints = 0;

if ($PSBoundParameters.ContainsKey('Test')) {
  Write-Output "Analysing specific scripts..."
  for ($index = 0; $index -lt $Test.Count; $index++) {
    Write-Output "Checking: $($Test[$index])"
    Invoke-ScriptAnalyzer -Path "$($Test[$index])"
    $results = Invoke-ScriptAnalyzer -Path "$($Test[$index])" -ReportSummary
    $errors += $results.Where( { $_.Severity -eq 'Error' }).Count
    $warnings += $results.Where( { $_.Severity -eq 'Warning' }).Count
    $hints += $results.Where( { $_.Severity -eq 'Information' }).Count
  }
} else {
  $binPath = Split-Path -Path $PSCommandPath -Parent
  $scriptPath = Split-Path -Path $binPath -Parent
  Push-Location "$scriptPath"
  Write-Output "Change directory to: $(Get-Location)"

  Write-Output "Analysing all PowerShell scripts..."
  Invoke-ScriptAnalyzer -Path . -Recurse
  $results = Invoke-ScriptAnalyzer -Path . -Recurse -ReportSummary
  $errors += $results.Where( { $_.Severity -eq 'Error' }).Count
  $warnings += $results.Where( { $_.Severity -eq 'Warning' }).Count
  $hints += $results.Where( { $_.Severity -eq 'Information' }).Count

  Pop-Location
  Write-Output "Change directory back to: $(Get-Location)"
}

# In this case even hints are considered a problem and will produce a non-zero exit code
$exitCode = $errors + $warnings + $hints
Exit $exitCode
