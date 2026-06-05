# pecuoc

Plugin de Claude Code para escribir y compilar entregas UOC (PEC/PAC/PR) con la clase LaTeX P3CTeX.

## Requisitos

- macOS
- MacTeX o TeX Live (proporciona `pdflatex`, `latexmk`, `bibtex`, `kpsewhich`, `mktexlsr`)
- Claude Code

## Instalación

```
/plugin marketplace add josete734/pecuoc
/plugin install pecuoc@josete734
/pecuoc:setup
```

## Uso

Invoca la skill `pecuoc-author` para escribir y compilar una entrega de forma interactiva, o el subagente `pecuoc-author` para generar un documento completo en un solo paso. Para empezar una entrega nueva, copia una de las carpetas de `skills/pecuoc-author/templates/` (`minimal` o `extended`) como punto de partida.

La prosa del documento es configurable por asignatura (catalán o castellano); el código y los identificadores van siempre en inglés.

## Qué hace el setup

El comando `/pecuoc:setup` ejecuta `scripts/install.sh`, que realiza los pasos siguientes:

1. Clona el repositorio P3CTeX en `~/P3CTeX`.
2. Crea symlinks en `~/Library/texmf/tex/latex/P3CTeX` y `~/Library/texmf/tex/latex/P3CTeX-code`.
3. Ejecuta `mktexlsr` para actualizar la base de datos de TeX.
4. Verifica la instalación con `kpsewhich P3CTeX.cls`.
5. Compila un documento de prueba para confirmar que todo funciona.

## Desinstalación

```bash
bash scripts/uninstall.sh   # elimina los symlinks y actualiza mktexlsr
rm -rf ~/P3CTeX             # elimina el repositorio clonado
```

Después desinstala el plugin desde Claude Code.

## Linux / Windows

El autoinstalador soporta oficialmente **macOS**.

- **Linux**: `TEXMFHOME` suele ser `~/texmf`; ajusta los symlinks de forma análoga y ejecuta `mktexlsr`.
- **Windows / MiKTeX**: registra la carpeta raíz usando MiKTeX Console o `initexmf --register-root`, luego actualiza la base de datos.

## Identidad visual UOC

P3CTeX ya incorpora los colores corporativos oficiales de la UOC: azul `#000078` y cian `#73EDFF`.

El logotipo de la UOC es una marca registrada y **no se incluye** en este repositorio. Si necesitas el logo para tus entregas, extráelo tú mismo desde tu copia de `Office-UOC-Generic.zip` y colócalo en `~/.pecuoc/assets`.

## Atribución

- **P3CTeX** © DidacLL, licencia GPL-3.0 — <https://github.com/DidacLL/P3CTeX>. Se clona como dependencia en tiempo de ejecución; no se redistribuye en este repositorio.
- **Plantillas oficiales UOC** © Universitat Oberta de Catalunya (UOC).

## Licencia

MIT — véase el archivo [LICENSE](LICENSE).
