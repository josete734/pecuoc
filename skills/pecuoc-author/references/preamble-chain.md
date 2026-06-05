# Cadena de preàmbuls P3CTeX

## Patró de tres fitxers

P3CTeX segueix un patró de reutilització on la configuració s'organitza en tres capes:

```
SharedPreamble.tex          ← dades comunes de l'estudiant (tots els documents)
  └── SubjectPreamble.tex   ← configuració de l'assignatura (totes les PAC/PR)
        └── PAC1/activity.tex  ← document de l'activitat
```

Cada fitxer fa `\input` del nivell superior, de manera que els canvis es propaguen automàticament.

---

## Capa 1 — `SharedPreamble.tex`

Conté les dades de l'estudiant i les opcions globals. **No és un document complet** (no té `\begin{document}`).

```latex
\documentclass[cat]{P3CTeX}  % idioma i classe

\PECTeXconfig{
  data = {
    student = {Maria García López},
    grade   = {Grau d'Enginyeria Informàtica}
  },
  no-plagi  % declaració de no-plagi activa per a tots els documents
}
```

Ubicació recomanada: arrel del directori del curs (p. ex., `~/curs/SharedPreamble.tex`).

---

## Capa 2 — `SubjectPreamble.tex` (o `MINPreamble.tex`)

Carrega `SharedPreamble.tex` i defineix una comanda `\LoadPreamble` que estableix les dades de l'assignatura i el perfil de portada. S'hi pot incloure la bibliografia amb `\AtEndDocument`.

```latex
\input{../SharedPreamble.tex}

\NewDocumentCommand{\LoadPreamble}{O{PR} m m}{
  \PECTeXconfig{
    data = {
      subj-fullname  = {Bases de Dades},
      subj-shortname = {BD},
      subj-code      = {06.503},
      ca-shortname   = {#2},
      ca-fullname    = {#3},
      date           = {\today}
    },
    #1   % perfil: PR, PAC, PEC, CA...
  }
  \PECTeXcover{outter-backtitle, subtitle, subsubtitle}
}

\AtEndDocument{
  \nocite{*}
  \bibliographystyle{abbrvnat}
  \bibliography{../references}
}
```

**Signatura de `\LoadPreamble`:**
- `#1` `[O{PR}]`: perfil P3CTeX (default `PR`)
- `#2` `{m}`: nom curt de l'activitat (p. ex., `PAC1`)
- `#3` `{m}`: nom complet de l'activitat (obligatori, entre claus)

Ubicació recomanada: directori de l'assignatura (p. ex., `~/curs/BD/SubjectPreamble.tex`).

---

## Capa 3 — `PAC1/activity.tex`

El document de l'activitat: carrega el preàmble de l'assignatura, crida `\LoadPreamble` i conté el cos del text.

```latex
\input{../SubjectPreamble.tex}
\LoadPreamble{PAC1}{Primera Prova d'Avaluació Continuada}

\begin{document}

\section{Introducció}
Text de la resposta.

\section{Exercici 1}
% \pxTable, \pxIMG, pxCode, \pxUMLDiagram...

\end{document}
```

La bibliografia s'inclou via `\AtEndDocument` en el preàmble de l'assignatura, de manera que no cal repetir-la a cada document.

---

## Estructura de directoris recomanada

```
curs/
├── SharedPreamble.tex         ← dades comunes
├── references.bib             ← bibliografia compartida
├── BD/
│   ├── SubjectPreamble.tex    ← preàmble de Bases de Dades
│   ├── PAC1/
│   │   └── activity.tex
│   └── PAC2/
│       └── activity.tex
└── PO/
    ├── SubjectPreamble.tex
    └── PAC1/
        └── activity.tex
```

---

## Crear una nova activitat (PAC2 a partir de PAC1)

1. Duplicar el directori: `cp -r PAC1 PAC2`
2. Editar `PAC2/activity.tex` i canviar `\LoadPreamble{PAC1}{...}` → `\LoadPreamble{PAC2}{...}`
3. Escriure el contingut de la nova activitat.

---

## Notes importants

- El camí de `\input` és **relatiu al fitxer que el conté**, no al directori de treball de LaTeX.
- La comanda `\bibliography{../references}` és relativa al directori del document `.tex` que es compila; cal que `BIBINPUTS` inclogui el directori pare (`BIBINPUTS=".:..:"`).
- Mai no facis `\begin{document}` ni `\end{document}` en `SharedPreamble.tex` ni en `SubjectPreamble.tex`.
