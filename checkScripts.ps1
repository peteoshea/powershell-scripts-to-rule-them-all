param(
    [Parameter(Mandatory=$false, Position=0, ValueFromRemainingArguments,
    HelpMessage="Enter one or more specific tests")]
    [string[]]
    $Test
)

if ($PSBoundParameters.ContainsKey('Test')) {
    Write-Output "Lint specific scripts..."
    for ($index = 0; $index -lt $Test.Count; $index++)
    {
       Write-Output "Analysing: $($Test[$index])"
       Invoke-ScriptAnalyzer -Path "$($Test[$index])" -ReportSummary
    }
} else {
    Write-Output "Lint all scripts..."
    Invoke-ScriptAnalyzer -Path .\script -Recurse -ReportSummary
}
