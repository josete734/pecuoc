---
description: Instala y registra P3CTeX en tu TeX Live (clona el repo en ~/P3CTeX, crea symlinks en TEXMFHOME, refresca la base de datos, verifica con kpsewhich y compila un documento de prueba).
---

Ejecuta el autoinstalador de pecuoc y reporta el resultado de forma clara al usuario.

1. Ejecuta el instalador:

   ```bash
   bash "${CLAUDE_PLUGIN_ROOT}/scripts/install.sh"
   ```

2. Si termina correctamente, ejecuta la verificación y muestra el número de páginas del PDF de prueba:

   ```bash
   bash "${CLAUDE_PLUGIN_ROOT}/scripts/verify.sh"
   ```

3. Resume al usuario: ruta de `~/P3CTeX`, el `TEXMFHOME` usado, la salida de `kpsewhich P3CTeX.cls`, y si el documento de prueba compiló.

4. Si algo falla:
   - `Falta 'pdflatex'…` → indica instalar MacTeX (https://tug.org/mactex/).
   - `kpsewhich no encuentra P3CTeX.cls` → re-ejecuta `install.sh`; revisa permisos de `~/Library/texmf`.
   - Para desinstalar: `bash "${CLAUDE_PLUGIN_ROOT}/scripts/uninstall.sh"`.
