#!/usr/bin/env bash
# pecuoc lint — linter pre-compilación para documentos P3CTeX.
# Detecta patrones frágiles habituales en .tex y .bib antes de compilar.
# No bloqueante: SIEMPRE termina con exit 0 salvo error de uso (exit 2).
set -uo pipefail

YELLOW='\033[1;33m'
NC='\033[0m'
warn(){ printf "${YELLOW}[lint]${NC} %s\n" "$*"; }
info(){ printf '[lint] %s\n' "$*"; }

usage(){
  cat <<'USAGE'
Uso: lint-tex.sh <archivo.tex|directorio> [más...]
  Revisa archivos .tex y .bib en busca de patrones frágiles para P3CTeX.
  Si un argumento es un directorio, se recogen *.tex y *.bib recursivamente.
USAGE
}

# Sin argumentos: imprime el uso y sale con código 2.
if [ "$#" -eq 0 ]; then
  usage >&2
  exit 2
fi

# Recoge la lista de archivos a revisar a partir de los argumentos.
# Los directorios se exploran recursivamente con find.
FILES=()
for arg in "$@"; do
  if [ -d "$arg" ]; then
    while IFS= read -r f; do
      FILES+=("$f")
    done < <(find "$arg" -type f \( -name '*.tex' -o -name '*.bib' \) 2>/dev/null)
  elif [ -f "$arg" ]; then
    FILES+=("$arg")
  else
    warn "no existe o no es accesible: $arg"
  fi
done

# Contador global de hallazgos. Se mantiene FUERA de cualquier 'cmd | while'
# para evitar el bug clásico de la subshell que pierde la variable.
FINDINGS=0

for file in "${FILES[@]}"; do
  case "$file" in
    *.tex)
      # ----------------------------------------------------------------
      # Patrón 1: \bigskip\\ (o \medskip / \smallskip seguido de \\)
      # fuera de tablas. Heurística: ignoramos líneas dentro de entornos
      # tabular/tabularx/array/longtable marcando un flag por archivo.
      # Sugerencia: usar \bigskip\par o \medskip + línea en blanco.
      # ----------------------------------------------------------------
      in_table=0
      lineno=0
      while IFS= read -r line || [ -n "$line" ]; do
        lineno=$((lineno + 1))
        case "$line" in
          *'\begin{tabular'*|*'\begin{array}'*|*'\begin{longtable}'*) in_table=1 ;;
        esac
        if [ "$in_table" -eq 0 ] && \
           printf '%s' "$line" | grep -Eq '\\(big|med|small)skip[[:space:]]*\\\\'; then
          warn "$file:$lineno: \\bigskip/\\medskip/\\smallskip seguido de \\\\ fuera de tabla."
          warn "       Sugerencia: usa '\\bigskip\\par' o '\\medskip' + una línea en blanco."
          FINDINGS=$((FINDINGS + 1))
        fi
        case "$line" in
          *'\end{tabular'*|*'\end{array}'*|*'\end{longtable}'*) in_table=0 ;;
        esac
      done < "$file"

      # ----------------------------------------------------------------
      # Patrón 2: \pxCodeIn{...} cuyo contenido entre llaves incluya
      # algún carácter activo: ~ \ # % _ ^ &
      # Sugerencia: \texttt{\textasciitilde} o \path.
      # ----------------------------------------------------------------
      while IFS= read -r m; do
        ln="${m%%:*}"
        warn "$file:$ln: \\pxCodeIn{...} con carácter activo (~ \\ # % _ ^ &) en su contenido."
        warn "       Sugerencia: usa '\\texttt{\\textasciitilde}' o '\\path' para rutas/símbolos."
        FINDINGS=$((FINDINGS + 1))
      done < <(grep -nE '\\pxCodeIn\{[^}]*[~\\#%_^&][^}]*\}' "$file" 2>/dev/null)

      # ----------------------------------------------------------------
      # Patrón 4: \pxCodeIn{...http(s)://...} — URL en código inline.
      # \pxCodeIn no parte líneas, así que una URL larga desborda el
      # margen (overfull hbox). Sugerencia: usar \url{...}.
      # ----------------------------------------------------------------
      while IFS= read -r m; do
        ln="${m%%:*}"
        warn "$file:$ln: \\pxCodeIn{...} con una URL (no parte líneas; desborda el margen)."
        warn "       Sugerencia: usa '\\url{...}' para URLs y cadenas largas."
        FINDINGS=$((FINDINGS + 1))
      done < <(grep -nE '\\pxCodeIn\{[^}]*https?://[^}]*\}' "$file" 2>/dev/null)
      ;;

    *.bib)
      # ----------------------------------------------------------------
      # Patrón 3: campo title con un comando LaTeX (barra + letras) sin
      # proteger con llaves. Heurística simple con grep.
      # Sugerencia: envolverlo, p.ej. {\LaTeX}.
      # ----------------------------------------------------------------
      while IFS= read -r m; do
        ln="${m%%:*}"
        warn "$file:$ln: campo 'title' con comando LaTeX (\\comando) sin proteger con llaves."
        warn "       Sugerencia: envuelve el comando, p.ej. {\\LaTeX}."
        FINDINGS=$((FINDINGS + 1))
      done < <(grep -niE 'title[[:space:]]*=[[:space:]]*[{"][^{]*\\[a-zA-Z]+' "$file" 2>/dev/null)
      ;;
  esac
done

if [ "$FINDINGS" -eq 0 ]; then
  info "sin patrones frágiles detectados"
else
  info "total de hallazgos: $FINDINGS (revisión no bloqueante)"
fi

exit 0
