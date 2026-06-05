#!/usr/bin/env bash
# pecuoc installer — clona P3CTeX y lo registra en TeX Live (macOS).
set -euo pipefail
P3CTEX_DIR="${P3CTEX_DIR:-$HOME/P3CTeX}"
REPO_URL="https://github.com/DidacLL/P3CTeX.git"
log(){ printf '\033[1;34m[pecuoc]\033[0m %s\n' "$*"; }
err(){ printf '\033[1;31m[pecuoc] ERROR:\033[0m %s\n' "$*" >&2; }

# 1. Binarios TeX requeridos
for bin in pdflatex latexmk kpsewhich mktexlsr bibtex; do
  command -v "$bin" >/dev/null 2>&1 || { err "Falta '$bin' en PATH. Instala MacTeX: https://tug.org/mactex/"; exit 1; }
done
log "TeX detectado: $(pdflatex --version | head -1)"

# 2. Clonar o actualizar P3CTeX
if [ -d "$P3CTEX_DIR/.git" ]; then
  log "Actualizando P3CTeX en $P3CTEX_DIR"; git -C "$P3CTEX_DIR" pull --ff-only || log "(pull omitido)"
else
  log "Clonando P3CTeX en $P3CTEX_DIR"; git clone --depth 1 "$REPO_URL" "$P3CTEX_DIR"
fi

# 3. Symlinks en TEXMFHOME
TEXMFHOME="$(kpsewhich -var-value=TEXMFHOME)"
[ -n "$TEXMFHOME" ] || { err "No se pudo determinar TEXMFHOME"; exit 2; }
log "TEXMFHOME = $TEXMFHOME"
mkdir -p "$TEXMFHOME/tex/latex"
ln -sfn "$P3CTEX_DIR/tex/latex" "$TEXMFHOME/tex/latex/P3CTeX"
ln -sfn "$P3CTEX_DIR/tex/code"  "$TEXMFHOME/tex/latex/P3CTeX-code"

# 4. Refrescar base de datos de nombres de archivo
mktexlsr "$TEXMFHOME" >/dev/null

# 5. Verificar descubrimiento de la clase
if CLS="$(kpsewhich P3CTeX.cls)" && [ -n "$CLS" ]; then
  log "OK: P3CTeX.cls -> $CLS"
else
  err "kpsewhich no encuentra P3CTeX.cls tras el registro"; exit 2
fi

# 6. Branding opcional (logo oficial) — solo local, nunca al repo
ZIP="$HOME/Downloads/Office-UOC-Generic.zip"
if [ -f "$ZIP" ]; then
  log "ZIP oficial UOC detectado en Downloads. Los colores oficiales ya están en P3CTeX."
  log "Si quieres el logo en portadas, extráelo localmente a ~/.pecuoc/assets (no se sube a ningún repo)."
fi
log "Setup completado. Prueba: bash \"\$(dirname \"\$0\")/verify.sh\""
