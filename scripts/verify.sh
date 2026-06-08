#!/usr/bin/env bash
# Compila un documento mínimo P3CTeX y verifica el PDF.
set -euo pipefail

# Cuenta las páginas de un PDF con una cadena de alternativas:
# 1) pdfinfo (poppler), 2) mdls (macOS Spotlight),
# 3) las marcas [N] del log de compilación de pdflatex.
pdf_pages() {
  if command -v pdfinfo >/dev/null 2>&1; then
    pdfinfo "$1" 2>/dev/null | awk '/^Pages/{print $2}'
  elif command -v mdls >/dev/null 2>&1; then
    mdls -name kMDItemNumberOfPages -raw "$1" 2>/dev/null
  else
    grep -oE '\[[0-9]+\]' "$TMP/probe.out" 2>/dev/null | tr -d '[]' | sort -n | tail -1
  fi
}

TMP="$(mktemp -d)"; trap 'rm -rf "$TMP"' EXIT
cat > "$TMP/probe.tex" <<'TEX'
\documentclass[es]{P3CTeX}
\PECTeXconfig{data={student={Test Student}, subj-shortname={TST}, subj-code={00.000}}}
\begin{document}
\section{Prueba}
Documento de prueba generado por pecuoc.
\end{document}
TEX
( cd "$TMP" && pdflatex -interaction=nonstopmode probe.tex >probe.out 2>&1 || true )
if [ -f "$TMP/probe.pdf" ]; then
  PAGES="$(pdf_pages "$TMP/probe.pdf")"
  echo "[pecuoc] OK: documento de prueba compilado (${PAGES:-?} páginas)"
else
  echo "[pecuoc] ERROR: el documento de prueba no compiló. Log:"; tail -20 "$TMP/probe.out"; exit 1
fi
