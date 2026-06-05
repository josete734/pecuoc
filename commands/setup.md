---
description: Instala y registra P3CTeX en tu TeX Live (clona el repo en ~/P3CTeX, crea symlinks en TEXMFHOME, refresca la base de datos, verifica con kpsewhich y compila un documento de prueba). Solo macOS.
allowed-tools: Bash
---

Ejecuta el autoinstalador de **pecuoc** y reporta el resultado al usuario.

Lanza este bloque tal cual. Localiza el instalador del plugin **sin depender de variables
de entorno** (usa `CLAUDE_PLUGIN_ROOT` solo si está disponible; si no, lo descubre en la
caché de plugins), lo ejecuta y a continuación corre la verificación:

```bash
# Resolver la ruta de install.sh del plugin de forma robusta
INSTALL="${CLAUDE_PLUGIN_ROOT:+$CLAUDE_PLUGIN_ROOT/scripts/install.sh}"
[ -f "$INSTALL" ] || INSTALL="$(find "$HOME/.claude/plugins" -path '*pecuoc*/scripts/install.sh' 2>/dev/null | head -1)"
[ -f "$INSTALL" ] || { echo "[pecuoc] No se encontró el instalador. Reinstala con: /plugin install pecuoc@josete734"; exit 1; }
echo "[pecuoc] usando: $INSTALL"
bash "$INSTALL" && bash "$(dirname "$INSTALL")/verify.sh"
```

Después, resume al usuario de forma clara:
- la ruta del clon (`~/P3CTeX`) y el `TEXMFHOME` utilizado,
- la salida de `kpsewhich P3CTeX.cls`,
- si el documento de prueba compiló y con cuántas páginas.

Si algo falla:
- `Falta 'pdflatex'…` → instala MacTeX: https://tug.org/mactex/
- `kpsewhich no encuentra P3CTeX.cls` → vuelve a ejecutar el bloque; revisa permisos de `~/Library/texmf`.
- Para desinstalar, ejecuta el `uninstall.sh` que vive junto a `install.sh` (mismo directorio).
