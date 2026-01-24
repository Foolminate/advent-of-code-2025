#!/bin/bash
set -euo pipefail

# 🛡️ Upfront Checks
echo "🔍 Validating environment..."
command -v uv >/dev/null 2>&1 || { echo "❌ uv missing: install at astral.sh/uv"; exit 1; }
command -v git >/dev/null 2>&1 || { echo "❌ git missing"; exit 1; }

# 📂 Ensure Git & Config state
[[ -d .git ]] || git init >/dev/null
if [[ -f .pre-commit-config.yaml ]]; then
    echo "⏭️ Config exists. Aborting to protect existing hooks."
    exit 0
fi

# ✍️ Side Effects Start Here
echo "📝 Creating .pre-commit-config.yaml..."
cat <<EOF > .pre-commit-config.yaml
repos:
  - repo: local
    hooks:
      - id: uv-sync
        name: uv-sync
        entry: uv sync
        language: system
        always_run: false
        files: ^uv\.lock$
        stages: [post-checkout, post-merge]
EOF

echo "📦 Adding pre-commit..."
uv add --dev pre-commit >/dev/null

echo "⚓ Installing hooks..."
uv run pre-commit install --hook-type post-checkout --hook-type post-merge >/dev/null

echo "✅ Done! uv will auto-sync on lockfile changes."