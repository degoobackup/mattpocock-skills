<#
.SYNOPSIS
Human-in-the-loop reproduction loop.
Copy this file, edit the steps below, and run it.
The agent runs the script; the user follows prompts in their terminal.

.DESCRIPTION
Two helpers:
  Step "<instruction>"          - show instruction, wait for Enter
  Capture "<VarName>" "<question>" - show question, read response into variable

At the end, captured values are printed as KEY=VALUE for the agent to parse.

.EXAMPLE
  pwsh hitl-loop.template.ps1
#>
$ErrorActionPreference = 'Stop'
$captured = @{}

function Step {
    param([string]$Instruction)
    Write-Host "`n>>> $Instruction"
    Read-Host '    [Enter when done]' | Out-Null
}

function Capture {
    param([string]$VarName, [string]$Question)
    Write-Host "`n>>> $Question"
    $answer = Read-Host '    >'
    $script:captured[$VarName] = $answer
}

# --- edit below ---------------------------------------------------------

Step 'Open the app at http://localhost:3000 and sign in.'

Capture 'ERRORED' "Click the 'Export' button. Did it throw an error? (y/n)"

Capture 'ERROR_MSG' 'Paste the error message (or "none"):'

# --- edit above ---------------------------------------------------------

Write-Host "`n--- Captured ---"
foreach ($kv in $captured.GetEnumerator()) {
    Write-Host "$($kv.Key)=$($kv.Value)"
}
