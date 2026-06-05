#!/usr/bin/env bash
set -euo pipefail
TEXMFHOME="$(kpsewhich -var-value=TEXMFHOME)"
rm -f "$TEXMFHOME/tex/latex/P3CTeX" "$TEXMFHOME/tex/latex/P3CTeX-code"
mktexlsr "$TEXMFHOME" >/dev/null
echo "[pecuoc] Symlinks de P3CTeX eliminados de $TEXMFHOME."
echo "[pecuoc] El clon ~/P3CTeX y el plugin se eliminan por separado (rm -rf ~/P3CTeX; /plugin uninstall)."
