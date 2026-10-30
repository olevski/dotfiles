#!/usr/bin/env bash
# Install herdr plugins. Re-runs whenever this file changes.
set -euo pipefail

command -v herdr >/dev/null || exit 0

# Name tabs and panes from their context (process, directory, branch, agent task).
# Built from source at install time, needs Go 1.24+.
herdr plugin install --yes kryptamine/herdr-auto-title --ref v0.17.0
herdr plugin action invoke herdr.auto-title.restart || true
