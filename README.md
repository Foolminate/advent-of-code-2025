# ⚡ UV Auto-Sync

This repo uses `uv` and `pre-commit` to ensure local environments are never out of sync with the project's dependencies. This is particularly useful for Jupyter Notebooks where 'uv run' (which syncs the lockfile) typically isn't used.

## 📋 Requirements
uv [Installation Guide](https://astral.sh/uv)

git [Installation Guide](https://git-scm.com/)

## 🛠️ One-Step Setup

```bash
# macOS/Linux
chmod +x uv-auto-sync.sh && ./uv-auto-sync.sh

# Windows (Git Bash / WSL)
sh uv-auto-sync.sh
```

## 🧠 How it Works

The script automates the "Self-Healing" environment logic:
1. 🛡️ **Checks**: Verifies `uv` and `git` exist before doing anything.
2. 📝 **Config**: Writes a `.pre-commit-config.yaml` to your root (won't overwrite if present).
3. 📦 **Deps**: Uses `uv` to add `pre-commit` to your development dependencies.
4. ⚓ **Hooks**: Registers `post-merge` (pulls) and `post-checkout` (branch swaps) hooks.

Whenever `uv.lock` changes during a git operation, the hook automatically triggers `uv sync`.