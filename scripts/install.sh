# Install avid-skill for Claude Code (Unix)

set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"

echo "Adding marketplace from: $ROOT"
claude plugin marketplace add "$ROOT" || true

echo "Installing avid-skill@avid-skill"
claude plugin install avid-skill@avid-skill || {
  echo "CLI install failed. Falling back to --plugin-dir hint:"
  echo "  claude --plugin-dir \"$ROOT\""
  exit 1
}

echo "Done. Open a new Claude Code session to load SessionStart hooks."
