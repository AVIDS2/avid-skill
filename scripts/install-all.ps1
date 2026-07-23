# Install avid-skill for Claude Code + Codex + OpenCode on Windows
$ErrorActionPreference = "Stop"
$Root = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$Skills = Join-Path $Root "skills"
$HomeDir = $env:USERPROFILE

Write-Host "==> avid-skill root: $Root"

function Ensure-Junction($Link, $Target) {
  if (Test-Path $Link) {
    $item = Get-Item $Link -Force
    if ($item.Attributes -band [IO.FileAttributes]::ReparsePoint) {
      Write-Host "    junction ok: $Link"
      return
    }
    Write-Host "    removing non-junction path: $Link"
    Remove-Item $Link -Recurse -Force
  }
  $parent = Split-Path $Link -Parent
  if (-not (Test-Path $parent)) { New-Item -ItemType Directory -Path $parent -Force | Out-Null }
  New-Item -ItemType Junction -Path $Link -Target $Target | Out-Null
  Write-Host "    linked $Link -> $Target"
}

function Upsert-AgentsBlock($Path, $Block) {
  $start = "<!-- AVID-SKILL-START -->"
  $end = "<!-- AVID-SKILL-END -->"
  $payload = @"
$start
$Block
$end
"@
  if (-not (Test-Path $Path)) {
    $dir = Split-Path $Path -Parent
    if ($dir -and -not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }
    Set-Content -Path $Path -Value $payload -Encoding UTF8
    Write-Host "    created $Path"
    return
  }
  $text = Get-Content -Path $Path -Raw -Encoding UTF8
  if ($text -match [regex]::Escape($start)) {
    $pattern = "(?s)" + [regex]::Escape($start) + ".*?" + [regex]::Escape($end)
    $newText = [regex]::Replace($text, $pattern, { param($m) $payload.TrimEnd() })
    Set-Content -Path $Path -Value $newText -Encoding UTF8 -NoNewline
    Write-Host "    updated AVID block in $Path"
  } else {
    $newText = $text.TrimEnd() + "`r`n`r`n" + $payload + "`r`n"
    Set-Content -Path $Path -Value $newText -Encoding UTF8 -NoNewline
    Write-Host "    appended AVID block to $Path"
  }
}

$agentsSnippet = @"
## AVID Skill (cross-tool)

If AVID skills are available, hard gates apply:

1. New product / new vertical -> ``product-bootstrap`` before business code (market brief + P0 slice).
2. Self-build a capability -> ``research-before-build``.
3. Missing tool -> ``install-dont-reinvent``.
4. Stack choices -> ``stack-defaults``.
5. Agent runtime -> ``agent-framework-choice`` (LangGraph vs Pi + docs).
6. Knowledge/RAG -> ``knowledge-architecture``.
7. High-stakes forks -> ``multi-agent-deliberation``.

Source: https://github.com/AVIDS2/avid-skill
"@

# --- Claude Code ---
Write-Host "`n==> Claude Code"
try {
  claude plugin marketplace add $Root 2>$null
} catch {}
try {
  claude plugin marketplace add AVIDS2/avid-skill 2>$null
} catch {}
try {
  claude plugin install "avid-skill@avid-skill" -s user
  Write-Host "    Claude plugin installed/enabled"
} catch {
  Write-Host "    Claude CLI install failed: $_"
  Write-Host "    Fallback: claude --plugin-dir `"$Root`""
}

# --- Codex: junction each skill into ~/.codex/skills ---
Write-Host "`n==> Codex (~/.codex/skills)"
$CodexSkills = Join-Path $HomeDir ".codex\skills"
if (-not (Test-Path $CodexSkills)) { New-Item -ItemType Directory -Path $CodexSkills -Force | Out-Null }
Get-ChildItem -Path $Skills -Directory | ForEach-Object {
  Ensure-Junction (Join-Path $CodexSkills $_.Name) $_.FullName
}
# Also mirror under ~/.agents/skills for multi-agent discovery
$AgentsSkills = Join-Path $HomeDir ".agents\skills"
if (-not (Test-Path $AgentsSkills)) { New-Item -ItemType Directory -Path $AgentsSkills -Force | Out-Null }
Get-ChildItem -Path $Skills -Directory | ForEach-Object {
  Ensure-Junction (Join-Path $AgentsSkills $_.Name) $_.FullName
}
Upsert-AgentsBlock (Join-Path $HomeDir ".codex\AGENTS.md") $agentsSnippet

# Optional: drop a local Codex plugin copy pointer
$CodexPluginDir = Join-Path $HomeDir ".codex\plugins\avid-skill"
if (-not (Test-Path $CodexPluginDir)) {
  try {
    New-Item -ItemType Junction -Path $CodexPluginDir -Target $Root | Out-Null
    Write-Host "    Codex plugin junction: $CodexPluginDir"
  } catch {
    Write-Host "    skip codex plugin junction: $_"
  }
}

# --- OpenCode ---
Write-Host "`n==> OpenCode"
$OcConfigDir = Join-Path $HomeDir ".config\opencode"
if (-not (Test-Path $OcConfigDir)) { New-Item -ItemType Directory -Path $OcConfigDir -Force | Out-Null }

# Prefer skills junction + plugin path in opencode.jsonc
$OcSkillsRoot = Join-Path $OcConfigDir "skills"
if (-not (Test-Path $OcSkillsRoot)) { New-Item -ItemType Directory -Path $OcSkillsRoot -Force | Out-Null }
Ensure-Junction (Join-Path $OcSkillsRoot "avid-skill") $Skills

# Prefer local package path on this machine (reliable on Windows); git URL for portability docs
$pluginEntryLocal = ($Root -replace '\\', '/')
$pluginEntryGit = "avid-skill@git+https://github.com/AVIDS2/avid-skill.git"

$OcJsonc = Join-Path $OcConfigDir "opencode.jsonc"
$OcJson = Join-Path $OcConfigDir "opencode.json"
$configPath = if (Test-Path $OcJsonc) { $OcJsonc } elseif (Test-Path $OcJson) { $OcJson } else { $null }

if ($configPath) {
  Write-Host "    patching $configPath"
  $raw = Get-Content $configPath -Raw -Encoding UTF8
  if ($raw -notmatch "avid-skill") {
    if ($raw -match '"plugin"\s*:\s*\[') {
      $raw = $raw -replace '("plugin"\s*:\s*\[)', "`$1`r`n    `"$pluginEntryLocal`","
      Set-Content -Path $configPath -Value $raw -Encoding UTF8 -NoNewline
      Write-Host "    appended local plugin path to plugin array: $pluginEntryLocal"
    } else {
      Write-Host "    no plugin array found — add manually:"
      Write-Host "      `"plugin`": [`"$pluginEntryLocal`"]"
      Write-Host "    or git: `"$pluginEntryGit`""
    }
  } else {
    Write-Host "    config already mentions avid-skill"
  }
} else {
  Write-Host "    no opencode.json(c) — creating minimal opencode.json"
  $skillsPosix = ($Skills -replace '\\', '/')
  @"
{
  "`$schema": "https://opencode.ai/config.json",
  "plugin": ["$pluginEntryLocal"],
  "skills": {
    "paths": ["$skillsPosix"]
  }
}
"@ | Set-Content -Path $OcJson -Encoding UTF8
}

Upsert-AgentsBlock (Join-Path $OcConfigDir "AGENTS.md") $agentsSnippet

Write-Host "`n==> Done"
Write-Host "Restart Claude Code / Codex / OpenCode sessions to load AVID."
Write-Host "Verify: ask each agent to run product-bootstrap on a fake new product."
