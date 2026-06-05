#!/usr/bin/env bash
# Hook SessionStart: avisa (sin bloquear) si P3CTeX no está registrado.
if ! kpsewhich P3CTeX.cls >/dev/null 2>&1; then
  cat <<'JSON'
{"hookSpecificOutput":{"hookEventName":"SessionStart","additionalContext":"pecuoc: P3CTeX no está registrado en TeX. Ejecuta /pecuoc:setup para clonar P3CTeX y registrarlo en TeX Live (macOS)."}}
JSON
fi
exit 0
