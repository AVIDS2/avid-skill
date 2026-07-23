# Install avid-skill for Claude Code (Windows PowerShell)
$ErrorActionPreference = "Stop"
$Root = Resolve-Path (Join-Path $PSScriptRoot "..")

Write-Host "Adding marketplace from: $Root"
try {
  claude plugin marketplace add "$Root"
} catch {
  Write-Host "marketplace add returned non-zero (may already exist): $_"
}

Write-Host "Installing avid-skill@avid-skill"
try {
  claude plugin install "avid-skill@avid-skill"
} catch {
  Write-Host "CLI install failed. Use local dir:"
  Write-Host "  claude --plugin-dir `"$Root`""
  throw
}

Write-Host "Done. Open a new Claude Code session to load SessionStart hooks."
