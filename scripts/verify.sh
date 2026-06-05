#!/usr/bin/env bash
# Compila un documento mínimo P3CTeX y verifica el PDF.
set -euo pipefail
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
  PAGES="$(pdfinfo "$TMP/probe.pdf" 2>/dev/null | awk '/Pages/{print $2}')"
  echo "[pecuoc] OK: documento de prueba compilado (${PAGES:-?} páginas)"
else
  echo "[pecuoc] ERROR: el documento de prueba no compiló. Log:"; tail -20 "$TMP/probe.out"; exit 1
fi
