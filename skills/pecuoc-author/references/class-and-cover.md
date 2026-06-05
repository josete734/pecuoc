# Classe P3CTeX — Opcions i portada

## `\documentclass[opcions]{P3CTeX}`

### Opcions individuals
| Opció | Efecte |
|---|---|
| `cover` | Genera portada |
| `no-cover` | Desactiva la portada |
| `toc` | Genera taula de continguts |
| `no-toc` | Desactiva la taula de continguts |
| `no-plagi` | Insereix la declaració de no-plagi |
| `cat` | Babel catalan (idioma de la portada i capçaleres) |
| `es` | Babel spanish |
| `en` | Babel english |

### Metaperfils (accesos directes)
| Perfil | Equivalent |
|---|---|
| `CA` | `cover=false, toc=true, no-plagi, en` |
| `PAC` | `cover=false, toc=true, no-plagi, cat` |
| `PEC` | `cover=false, toc=true, no-plagi, es` |
| `PR` | `cover=true, toc=true` |
| `default` | (sense perfil explícit) |

**Exemple:**
```latex
\documentclass[cat]{P3CTeX}   % idioma per babel; perfil definit a \PECTeXconfig
```

---

## `\PECTeXconfig{claus}`

Configura metadades i comportament del document. Pot cridar-se múltiples vegades; els valors s'acumulen.

### Claus de dades (`data={...}`)
| Clau | Descripció |
|---|---|
| `student` | Nom complet de l'estudiant |
| `grade` | Nom de la titulació |
| `subj-fullname` | Nom complet de l'assignatura |
| `subj-shortname` | Abreviatura de l'assignatura (per a la capçalera) |
| `subj-code` | Codi de l'assignatura |
| `ca-fullname` | Nom complet de l'activitat (PAC1, PR2…) |
| `ca-shortname` | Abreviatura de l'activitat |
| `date` | Data del document |

Totes les claus de dades s'inclouen dins de `data={...}`.

**Exemple:**
```latex
\PECTeXconfig{
  data = {
    student       = {Maria García López},
    grade         = {Grau d'Enginyeria Informàtica},
    subj-fullname  = {Bases de Dades},
    subj-shortname = {BD},
    subj-code      = {06.503},
    ca-fullname    = {Primera Prova d'Avaluació Continuada},
    ca-shortname   = {PAC1},
    date           = {\today}
  },
  PAC
}
```

### Altres claus de `\PECTeXconfig`
| Clau | Descripció |
|---|---|
| `cover` / `no-cover` | Activa/desactiva la portada |
| `toc` / `no-toc` | Activa/desactiva la taula de continguts |
| `no-plagi` | Activa la declaració de no-plagi |
| `cat` / `es` / `en` | Selecció d'idioma (babel) |
| `CA`, `PAC`, `PEC`, `PR` | Metaperfils (vegeu taula anterior) |

---

## `\PECTeXcover{claus}`

Configura el disseny de la portada. Totes les claus s'envien al motor `gdxCOVER`.

### Elements visibles (booleans — presència activa l'element)
| Clau | Descripció |
|---|---|
| `uppertitle` | Mostra el text superior de la portada |
| `subtitle` | Mostra el subtítol |
| `subsubtitle` | Mostra el sub-subtítol (codi d'assignatura per defecte) |
| `add-picture` | Mostra la imatge principal |
| `outter-backtitle` | Backtitle sobre fons de color (exterior) |
| `inner-backtitle` | Backtitle sobre fons blanc (interior) |
| `noplagi` | Afegeix la declaració de no-plagi a la portada |

### Textos de la portada
| Clau | Valor per defecte |
|---|---|
| `text-uppertitle` | Nom del document (`ca-fullname`) |
| `text-title` | Nom de l'assignatura |
| `text-subtitle` | Nom del document |
| `text-subsubtitle` | Codi de referència (`subj-code`) |
| `text-author` | Nom de l'estudiant |
| `text-date` | Data (`\today`) |

### Imatges de la portada
| Clau | Descripció |
|---|---|
| `set-mainpicture` | Nom/ruta de la imatge principal (format llarg) |
| `set-auxpicture` | Nom/ruta de la imatge auxiliar (format quadrat) |

### Colors de la portada
| Clau | Color per defecte |
|---|---|
| `maincolor` | `secondaryColor` (cian UOC) |
| `auxcolor` | `lightColor` |
| `textcolor` | `primaryColor` (blau UOC) |

### Metaperfils de portada
| Clau | Efecte |
|---|---|
| `fullcover` | Activa tots els elements: uppertitle, subtitle, subsubtitle, imatge, backtitle, noplagi |
| `defaultcover` | Activa subtitle, subsubtitle, outter-backtitle, noplagi; desactiva uppertitle i imatge |

**Exemple:**
```latex
\PECTeXcover{
  outter-backtitle,
  subtitle,
  subsubtitle,
  text-subsubtitle = {2025/2026-S2}
}
```

---

## `\PECTeXpage{claus}` i `\PECTeXpdf{claus}`

Configuren l'estil de la pàgina (capçalera/peu) i les metadades PDF.

```latex
\PECTeXpage{
  author-name  = {Maria García},
  doc-name     = {PAC1},
  subj-name    = {BD}
}

\PECTeXpdf{
  title   = {PAC1 - Bases de Dades},
  author  = {Maria García López}
}
```

---

## Selecció d'idioma i babel

L'idioma s'ha de definir **a `\documentclass[...]`** o **a la primera crida a `\PECTeXconfig`** perquè babel es carregui correctament.

| Valor | Efecte babel |
|---|---|
| `cat` | `\RequirePackage[catalan]{babel}` |
| `es` | `\RequirePackage[spanish]{babel}` |
| `en` | `\RequirePackage[english]{babel}` |

```latex
% Opció recomanada: idioma a la línia \documentclass
\documentclass[cat]{P3CTeX}
```
