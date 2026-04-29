<#
.SYNOPSIS
Links all skills in the repository to ~/.claude/skills so they can be
used by the local Claude CLI.
#>
$ErrorActionPreference = 'Stop'

$Repo = Split-Path -Parent $PSScriptRoot
$Dest = Join-Path $HOME '.claude' 'skills'

if ((Get-Item $Dest -ErrorAction SilentlyContinue).LinkType -eq 'SymbolicLink') {
    $resolved = (Get-Item $Dest).Target
    if ($resolved -eq $Repo -or $resolved.StartsWith("$Repo\")) {
        Write-Error "$Dest is a symlink into this repo ($resolved). Remove it and re-run; the script will recreate it as a real dir."
        exit 1
    }
}

if (-not (Test-Path $Dest)) {
    New-Item -ItemType Directory -Path $Dest -Force | Out-Null
}

Get-ChildItem -Path "$Repo\skills" -Filter 'SKILL.md' -Recurse |
    Where-Object { $_.FullName -notlike '*\node_modules\*' } |
    ForEach-Object {
        $src = $_.Directory.FullName
        $name = $_.Directory.Name
        $target = Join-Path $Dest $name

        if ((Test-Path $target) -and -not (Get-Item $target).LinkType) {
            Remove-Item -Recurse -Force $target
        }

        New-Item -ItemType SymbolicLink -Path $target -Target $src -Force | Out-Null
        Write-Host "linked $name -> $src"
    }
