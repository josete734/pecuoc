# Compilació de documents P3CTeX en macOS

## Flux registrat (recomanat)

Si P3CTeX està registrat a TeX Live (via `/pecuoc:setup` o U2), la compilació és directa:

```bash
cd ruta/del/document
latexmk -pdf -interaction=nonstopmode activity.tex
```

`latexmk` s'encarrega automàticament de les passades múltiples i de cridar `bibtex` per a la bibliografia.

### Verificació
```bash
ls activity.pdf                    # ha d'existir
pdfinfo activity.pdf | grep Pages  # ha de mostrar Pages: N (N ≥ 1)
```

> **Nota:** `pdfinfo` forma part de **poppler** (instal·lable via Homebrew: `brew install poppler`) i **no** s'inclou amb MacTeX. Si no el tens disponible, pots usar la funció següent que intenta diverses alternatives:
>
> ```bash
> pages() {
>   if command -v pdfinfo &>/dev/null; then
>     pdfinfo "$1" | awk '/^Pages/{print $2}'
>   elif command -v mdls &>/dev/null; then
>     mdls -name kMDItemNumberOfPages -raw "$1"
>   else
>     # Compta les marques de pàgina [N] del fitxer .log
>     grep -oE '\[[0-9]+\]' "${1%.pdf}.log" \
>       | tr -d '[]' | sort -n | tail -1
>   fi
> }
> pages activity.pdf
> ```
>
> La funció prova: (1) `pdfinfo` si existeix; (2) `mdls` (metadades Spotlight de macOS); (3) anàlisi del `.log` buscant les marques `[N]` que pdflatex escriu per a cada pàgina, ordenades numèricament per obtenir la darrera.

---

## Flux portàtil (sense registre global)

Si P3CTeX no està registrat, cal indicar a TeX Live on trobar els fitxers:

```bash
export TEXINPUTS=".:$HOME/P3CTeX/tex/latex//:$HOME/P3CTeX/tex/code//:"
export BIBINPUTS=".:..:."

cd ruta/del/document
latexmk -pdf -interaction=nonstopmode activity.tex
```

Els dobles barres `//` al final d'un directori indiquen a `kpathsea` que cerqui recursivament.

---

## Gestió de la bibliografia

P3CTeX usa **bibtex** (no biber). `latexmk` l'invoca automàticament si detecta `\bibliography{...}` al document.

Per a compilació manual en dos passos:
```bash
pdflatex -interaction=nonstopmode activity.tex
bibtex activity
pdflatex -interaction=nonstopmode activity.tex
pdflatex -interaction=nonstopmode activity.tex
```

El fitxer `references.bib` ha de ser localitzable. Si és un directori amunt:
```bash
export BIBINPUTS=".:..:."
```

### Protecció de títols a .bib

Els estils com `abbrvnat` o `plain` converteixen el títol a minúscules automàticament. Per preservar majúscules o comandes LaTeX dins del camp `title`, cal embolcallar-les amb claus `{}`:

```bibtex
title = {Una introducció a {\LaTeX} i la {UOC}}
```

Sense les claus, `\LaTeX` es transforma en `\latex` (comanda inexistent), la qual cosa provoca l'error **"Undefined control sequence"** al fitxer `.bbl` durant la compilació.

A més, tota entrada `.bib` ha de tenir el camp `year`. Si manca, BibTeX avisa amb **"empty year"** al fitxer `.blg`.

---

## Interpretació del codi de sortida de `latexmk`

| Codi | Significat |
|---|---|
| `0` | Compilació correcta sense advertències |
| `12` | `latexmk` ha detectat un error recuperable però **pot haver generat el PDF igualment** |
| `1` o altres | Error real; el PDF probablement no s'ha creat o és incomplet |

**Regla:** comprova sempre si `activity.pdf` existeix i té pàgines. Un codi de sortida `12` **no és necessàriament un error fatal**.

---

## Errors freqüents

### `File 'P3CTeX.code.tex' not found`
P3CTeX no és accessible per TeX Live.

**Solució:** executa `/pecuoc:setup` per registrar-lo, o estableix `TEXINPUTS` manualment (vegeu flux portàtil).

### `There's no line here to end` / `\bigskip\\`
El document conté `\bigskip\\` o una altra comanda `\bigskip` seguida de `\\` fora d'un entorn tabular/array.

**Solució:** substitueix per `\bigskip\par` o simplement un paràgraf en blanc. **Mai** escriguis `\bigskip\\` en un document P3CTeX.

```latex
% MAL  — causa l'error:
\bigskip\\

% BÉ   — alternativa correcta:
\bigskip\par

% BÉ   — o simplement una línia en blanc:
\medskip

Text nou...
```

### `LaTeX Error: \begin{document} ended by \end{...}`
Un dels fitxers d'entrada (`SharedPreamble.tex`, `SubjectPreamble.tex`) conté accidentalment un `\begin{document}`.

**Solució:** els fitxers de preàmble no han de tenir `\begin{document}` ni `\end{document}`.

### La portada no apareix
`cover` no està activat. Comprova que el perfil o les opcions inclouen `cover` o `PR`.

```latex
\PECTeXconfig{PR}  % activa portada i TOC
```

### La taula de continguts apareix buida
Pot ser que sigui la primera compilació. `latexmk` normalment resol els dos passos automàticament; si fas compilació manual, executa `pdflatex` dues vegades.

---

## Neteja de fitxers auxiliars

```bash
latexmk -C activity.tex
```

Elimina `.aux`, `.log`, `.toc`, `.bbl`, `.blg`, `.fls`, `.fdb_latexmk` i altres fitxers generats.
