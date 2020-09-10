param(
    [Parameter(Mandatory=$false, Position=0, ValueFromRemainingArguments,
    HelpMessage="Enter one or more specific tests")]
    [string[]]
    $Test
)

if ($PSBoundParameters.ContainsKey('Test')) {
    Write-Output "Run specific tests"
    for ($index = 0; $index -lt $Test.Count; $index++)
    {
       Write-Output "Test: $($Test[$index])"
       Invoke-ScriptAnalyzer -Path "$($Test[$index])"
    }
} else {
    Write-Output "Run all tests"
    Invoke-ScriptAnalyzer -Path .\script -Recurse
}
