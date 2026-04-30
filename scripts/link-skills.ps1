<#
.SYNOPSIS
Links all skills in the repository to ~/.claude/skills so they can be
used by the local Claude CLI.

Uses NTFS directory junctions (not symlinks) so the script works for
non-admin users without Developer Mode. Junctions only work within the
same volume — if your repo and home directory are on different drives,
either move one or run from an elevated shell and switch to symlinks.
#>
$ErrorActionPreference = 'Stop'

$Repo = Split-Path -Parent $PSScriptRoot
$Dest = Join-Path (Join-Path $HOME '.claude') 'skills'

$destItem = Get-Item $Dest -ErrorAction SilentlyContinue
if ($destItem -and ($destItem.LinkType -eq 'SymbolicLink' -or $destItem.LinkType -eq 'Junction')) {
    $resolved = @($destItem.Target)[0]
    if ($resolved -eq $Repo -or $resolved.StartsWith("$Repo\")) {
        Write-Error "$Dest is a link into this repo ($resolved). Remove it and re-run; the script will recreate it as a real dir."
        exit 1
    }
}

if (-not (Test-Path $Dest)) {
    New-Item -ItemType Directory -Path $Dest -Force | Out-Null
}

Get-ChildItem -Path (Join-Path $Repo 'skills') -Filter 'SKILL.md' -Recurse |
    Where-Object { $_.FullName -notlike '*\node_modules\*' } |
    ForEach-Object {
        $src = $_.Directory.FullName
        $name = $_.Directory.Name
        $target = Join-Path $Dest $name

        $existing = Get-Item $target -ErrorAction SilentlyContinue
        if ($existing) {
            if ($existing.LinkType) {
                # Remove existing link (junction or symlink) so we can refresh it.
                # Use [System.IO.Directory]::Delete because Remove-Item on a
                # junction can recurse into the target on older PowerShell.
                [System.IO.Directory]::Delete($target, $false)
            } else {
                Remove-Item -Recurse -Force $target
            }
        }

        New-Item -ItemType Junction -Path $target -Value $src | Out-Null
        Write-Host "linked $name -> $src"
    }
