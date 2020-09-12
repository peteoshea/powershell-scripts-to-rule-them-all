param(
    [Parameter(Mandatory=$false, Position=0, ValueFromRemainingArguments,
    HelpMessage="Enter one or more specific tests")]
    [string[]]
    $Test
)

$errors = 0;
$warnings = 0;
$hints = 0;

if ($PSBoundParameters.ContainsKey('Test')) {
    Write-Output "Lint specific scripts..."
    for ($index = 0; $index -lt $Test.Count; $index++)
    {
       Write-Output "Analysing: $($Test[$index])"
       $results = Invoke-ScriptAnalyzer -Path "$($Test[$index])" -ReportSummary
       $errors += $results.Where({$_.Severity -eq 'Error'}).Count
       $warnings += $results.Where({$_.Severity -eq 'Warning'}).Count
       $hints += $results.Where({$_.Severity -eq 'Information'}).Count
    }
} else {
    Write-Output "Lint all scripts..."
    $results = Invoke-ScriptAnalyzer -Path .\script -Recurse -ReportSummary
    $errors += $results.Where({$_.Severity -eq 'Error'}).Count
    $warnings += $results.Where({$_.Severity -eq 'Warning'}).Count
    $hints += $results.Where({$_.Severity -eq 'Information'}).Count
}

# In this case even hints are considered a problem and will produce a non-zero exit code
$exitCode = $errors + $warnings + $hints
Exit $exitCode
