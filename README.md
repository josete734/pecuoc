<div align="center">

# pecuoc

**Escribe y compila tus entregas de la UOC (PEC / PAC / PR) en LaTeX, desde Claude Code.**

Plugin de [Claude Code](https://claude.com/claude-code) que envuelve la clase LaTeX
[**P3CTeX**](https://github.com/DidacLL/P3CTeX) con una skill, un subagente y un
autoinstalador para macOS.

![version](https://img.shields.io/badge/version-0.2.0-3FB984)
![license](https://img.shields.io/badge/license-MIT-blue)
![platform](https://img.shields.io/badge/platform-macOS-lightgrey)
![Claude Code](https://img.shields.io/badge/Claude%20Code-plugin-CC785C)
![LaTeX](https://img.shields.io/badge/LaTeX-P3CTeX-000078)

</div>

---

## 🚀 Inicio rápido

```text
/plugin marketplace add josete734/pecuoc
/plugin install pecuoc@josete734
/pecuoc:setup
```

`/pecuoc:setup` deja tu entorno LaTeX listo (clona P3CTeX, lo registra en TeX Live y compila
un documento de prueba). Después, pide a la skill o al subagente `pecuoc-author` que te
escriba una entrega, o copia una plantilla de `skills/pecuoc-author/templates/`.

## ✨ Características

| | |
|---|---|
| 📝 **Autoría guiada** | Skill `pecuoc-author` con cheatsheets verificados de la API `px*` (tablas, código, UML, imágenes, datos). |
| 🤖 **Subagente** | `pecuoc-author` genera una entrega completa: redacta, compila y verifica el PDF. |
| ⚙️ **Autoinstalador** | `/pecuoc:setup` configura P3CTeX en macOS/TeX Live de forma idempotente y reversible. |
| 🎨 **Identidad oficial UOC** | P3CTeX ya usa los colores corporativos oficiales (azul `#000078`, cian `#73EDFF`). |
| 🌐 **Idioma por asignatura** | Prosa en catalán o castellano; código e identificadores en inglés. |
| 🔔 **Aviso automático** | Un hook `SessionStart` te recuerda ejecutar `/pecuoc:setup` si falta el entorno. |

## 📦 Requisitos

- **macOS**
- **MacTeX** o **TeX Live** (aporta `pdflatex`, `latexmk`, `bibtex`, `kpsewhich`, `mktexlsr`) — [descarga](https://tug.org/mactex/)
- **Claude Code**

## 🧭 Uso

- **Escribir/compilar interactivamente** → invoca la skill `pecuoc-author` (o simplemente trabaja en un `.tex` con `\documentclass{P3CTeX}`).
- **Generar una entrega completa** → invoca el subagente `pecuoc-author` (redacta + compila + verifica).
- **Empezar de cero** → copia `skills/pecuoc-author/templates/minimal` o `…/extended`.
- **Ver un ejemplo real y completo** → carpeta [`examples/POO`](examples/POO).

Compila con `latexmk -pdf -interaction=nonstopmode <doc>.tex`. La bibliografía usa **bibtex**.
El éxito se mide por el **PDF generado** (no por el código de salida): `latexmk` puede devolver
un código distinto de cero ante errores recuperables y aun así producir el PDF.

## 🔧 Qué hace `/pecuoc:setup`

1. Clona **P3CTeX** en `~/P3CTeX`.
2. Crea symlinks en `~/Library/texmf/tex/latex/P3CTeX` y `…/P3CTeX-code`.
3. Ejecuta `mktexlsr` para actualizar la base de datos de TeX.
4. Verifica con `kpsewhich P3CTeX.cls`.
5. Compila un documento de prueba para confirmar que todo funciona.

Es **idempotente** (puedes re-ejecutarlo) y **no toca** el árbol de TeX del sistema.

## 🗑️ Desinstalación

```bash
bash scripts/uninstall.sh   # elimina los symlinks y actualiza mktexlsr
rm -rf ~/P3CTeX             # elimina el repositorio clonado
```

Después, desinstala el plugin desde Claude Code (`/plugin uninstall pecuoc@josete734`).

## 🐧 Linux / 🪟 Windows

El autoinstalador soporta oficialmente **macOS**. En otros sistemas:

- **Linux**: `TEXMFHOME` suele ser `~/texmf`; crea los symlinks de forma análoga y ejecuta `mktexlsr`.
- **Windows / MiKTeX**: registra la carpeta raíz con MiKTeX Console o `initexmf --register-root`, y actualiza la base de datos.

## 🎨 Identidad visual UOC

P3CTeX ya incorpora los colores corporativos oficiales de la UOC: azul `#000078` y cian `#73EDFF`.

El **logotipo** de la UOC es una marca registrada y **no se incluye** en este repositorio. Si
necesitas el logo para tus portadas, extráelo tú mismo desde tu copia de
`Office-UOC-Generic.zip` y colócalo en `~/.pecuoc/assets`.

## 🙏 Atribución

- **P3CTeX** © [DidacLL](https://github.com/DidacLL/P3CTeX) — licencia **GPL-3.0**. Se clona como
  dependencia en tiempo de ejecución; **no se redistribuye** su código en este repositorio.
- **Plantillas oficiales UOC** © Universitat Oberta de Catalunya (UOC).

## 📄 Licencia

**MIT** — véase [LICENSE](LICENSE).
