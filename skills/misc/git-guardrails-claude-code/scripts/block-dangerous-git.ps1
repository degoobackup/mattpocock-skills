$ErrorActionPreference = 'Stop'

$input_json = $input | Out-String
$command = ($input_json | ConvertFrom-Json).tool_input.command

$dangerousPatterns = @(
    'git push'
    'git reset --hard'
    'git clean -fd'
    'git clean -f'
    'git branch -D'
    'git checkout \.'
    'git restore \.'
    'push --force'
    'reset --hard'
)

foreach ($pattern in $dangerousPatterns) {
    if ($command -match [regex]::Escape($pattern)) {
        Write-Error "BLOCKED: '$command' matches dangerous pattern '$pattern'. The user has prevented you from doing this."
        exit 2
    }
}

exit 0
