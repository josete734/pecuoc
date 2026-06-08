---
name: pecuoc-author
description: Use when writing or compiling UOC coursework (PEC/PAC/PR) with the P3CTeX LaTeX class and px* modules. Triggers on P3CTeX, UOC, PEC, PAC, PR, or files with \documentclass{P3CTeX}.
---

# P3CTeX Author (UOC)

You help students write clean, well-structured PEC/PAC/PR documents using the **P3CTeX**
class and its `px*` modules, and compile them on macOS/TeX Live.

## Mental model
- Class `P3CTeX.cls` + core `pxCORE.sty` load independent `px*` modules.
- Author-facing API only (never touch `tex/code/*.code.tex` internals).
- Preamble chain: `SharedPreamble.tex` (student data) → subject preamble → activity `.tex`.

## Language (configurable per subject)
- Ask/detect Catalan vs Spanish per subject; set `\documentclass[cat]` or `[es]` (babel).
- Document prose in the chosen language; **code and comments in English**.

## Prefer P3CTeX modules over raw LaTeX
- Images → `\pxIMG`, `\pxIMGpair`, `\pxIMGList` (pxSRC)
- Tables → `\pxTable`/`\pxTBL` + `\pxTABsetup` (pxTAB)
- Code → `pxCode` env, `\pxCodeIn`, `\pxCodeFile` (pxLST)
- UML → `\pxUMLClass` + `\pxUMLDiagram` (pxUML)
- Data → `\NEW/\SET/\GET` (pxPRP)
See `references/modules.md` for exact signatures, `references/class-and-cover.md` for the
class/cover keys, `references/preamble-chain.md` for the preamble pattern, and
`references/uoc-brand.md` for official UOC colors.

## Compiling & verifying (macOS) — see references/compile-macos.md
- With P3CTeX registered (via /pecuoc:setup) just run `latexmk -pdf -interaction=nonstopmode <doc>.tex`.
- Bibliography uses **bibtex**; keep `references.bib` reachable (`BIBINPUTS`).
- A recoverable error can still produce a PDF and make latexmk exit 12 — **verify the PDF
  exists and has pages**, then read the `.log` for real errors. Never emit `\bigskip\\`
  (use `\bigskip\par` or `\medskip` + blank line).
- **Gotchas:** `\pxCodeIn` is not verbatim (avoid `~`, `\`, `#`, `%`, `_`) and doesn't line-break (use `\url{}` for URLs); wrap
  commands and capitals in `.bib` titles with braces (e.g. `{\LaTeX}`, `{UOC}`); confirm page count via
  `pdfinfo` → `mdls` → count `[N]` entries in the `.log` — see `references/compile-macos.md`
  for details.

## When to delegate
For a full document (generate + compile + verify, iterate on errors), invoke the
`pecuoc-author` subagent. For quick questions and small edits, answer inline using the
references. To start from scratch, copy a folder from `templates/`.

## If P3CTeX is not installed
If `kpsewhich P3CTeX.cls` is empty, tell the user to run `/pecuoc:setup`.
