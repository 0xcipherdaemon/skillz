# Install ALL skills into the CURRENT project (only this project, nothing global).
#   Claude Code reads  <project>\.claude\skills
#   Codex reads        <project>\.agents\skills
# Works in Windows PowerShell 5.1+ and PowerShell 7 (Windows, macOS, Linux).
#
# One-liner, run from your project root:
#   git -c core.longpaths=true clone --depth 1 https://github.com/0xcipherdaemon/skillz.git .skillz; .\.skillz\install.ps1; Remove-Item .skillz -Recurse -Force
#
# Options:
#   -Target claude|codex|both   where to install (default: both)
#   -Only a,b                   only these groups        -Skip a,b   everything except these groups
param(
  [ValidateSet('claude','codex','both')][string]$Target = 'both',
  [string[]]$Only = @(), [string[]]$Skip = @()
)
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$dests = switch ($Target) { 'claude' { @('.claude/skills') } 'codex' { @('.agents/skills') } default { @('.claude/skills', '.agents/skills') } }
$count = 0
foreach ($g in Get-ChildItem (Join-Path $here 'plugins') -Directory) {
  $sd = Join-Path $g.FullName 'skills'
  if (-not (Test-Path $sd)) { continue }
  if ($Only.Count -gt 0 -and $Only -notcontains $g.Name) { continue }
  if ($Skip -contains $g.Name) { continue }
  foreach ($s in Get-ChildItem $sd -Directory) {
    foreach ($d in $dests) {
      New-Item -ItemType Directory -Force $d | Out-Null
      $t = Join-Path $d $s.Name
      if (Test-Path $t) { Remove-Item $t -Recurse -Force }
      Copy-Item $s.FullName $t -Recurse
    }
    $count++
  }
}
Write-Host "Installed $count skills into: $($dests -join ', ')  (in $((Get-Location).Path))"
