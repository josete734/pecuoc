# Mòduls px* de P3CTeX

> **Nota de nomenclatura important:** `pxSRC` és el mòdul d'**imatges** i `pxLST` és el mòdul de **codi**. La documentació d'alguns exemples del repositori intercanvia els noms; el codi font dels `.sty` és autoritatiu.

---

## pxTAB — Taules

### `\pxTABsetup{claus}`
Configura les opcions globals de pxTAB (estil, colors, marges).

```latex
\pxTABsetup{style=striped, arraystretch=1.3}
```

### `\pxTABsavepreset{nom}{claus}` i `\pxTABusepreset{nom}`
Desa i recupera una combinació de claus com a preset reutilitzable.

```latex
\pxTABsavepreset{el-meu-estil}{style=header, headerbgcolor=primaryColor}
\pxTABusepreset{el-meu-estil}
```

**Presets predefinits** (disponibles quan es fa servir `P3CTeX.cls`):
`p3c-header`, `p3c-data`, `p3c-rubric`, `p3c-minimal`, `p3c-exam`.

### `\pxTable[opcions]{fila1}{fila2}…{filaN}`
Genera una taula a partir de files com a llistes separades per comes.

```latex
\pxTABsetup{style=header}
\pxTable{Nom, Edat, Ciutat}
        {Alice, 22, Barcelona}
        {Bob, 25, Madrid}
```

### `\pxTableFromList[opcions]{dades}`
Taula des d'una cadena amb files separades per `;` i cel·les per `,`.

```latex
\pxTableFromList[style=striped]{%
  Nom, Nota; Alice, 8.5; Bob, 7.0%
}
```

### `\pxTableRow[opcions]{fila}`
Taula d'una sola fila (útil per a capçaleres).

### `\pxTableHeadBody[opcions]{capçalera}{cos}`
Separa explícitament la capçalera del cos (cos com a llista plana).

### `\pxTableHeadBodyRows[opcions]{capçalera}{fila1}…`
Com l'anterior però el cos s'especifica com a arguments separats.

### `\pxTableMatrix[opcions]{files}{cols}{cel·les}`
Genera una taula de matriu a partir d'una llista plana de cel·les.

### `\pxTBL[*][amplada]{numcols}[gap]{capçaleres}[prefix]{files}`
Sintaxi compacta per a taules. `*` aplica color de variació.

```latex
\pxTBL{3}{Mòdul, Crèdits, Nota}%
  {BD, 6, 8.0; PO, 6, 7.5; SO, 6, 9.0}
```

### `\pxTBLlong` i `\pxTBLtop`
Com `\pxTBL` però per a taules llargues (multipage) i taules amb capçalera flotant al principi, respectivament.

**Estils de taula disponibles:** `plain` | `header` | `striped` | `boxed` | `grid` | `header-striped` | `header-grid`

---

## pxLST — Codi

### `\pxCodeSet[paleta]{llenguatge}[estil]`
Configura l'idioma i la paleta actius globalment.

- `paleta`: `dark` (default) | `pastel` | `light`
- `estil`: nom de l'estil lstlisting (default `pxlst`)

```latex
\pxCodeSet[dark]{pxJava}
```

**Llenguatges predefinits:** `pxJava`, `pxPython`, `pxJS`, `pxC`, `pxSQL`, `pxBash`

### Entorn `pxCode[opcions]{etiqueta}`
Bloc de codi amb marc Darcula i barra de títol.

```latex
\begin{pxCode}[language=pxJava]{Exemple Java}
public class Hello {
    public static void main(String[] args) {
        System.out.println("Hello, UOC!");
    }
}
\end{pxCode}
```

### Entorn `pxCode*[opcions]{etiqueta}`
Com `pxCode` però amb estil de fons alternatiu (més fosc).

### Entorn `CodeBox[opcions]{ref}{títol}{nota-curta}{cos-comentari}`
Bloc de codi amb panell de comentari lateral (no es trenca entre pàgines).

```latex
\begin{CodeBox}{ex1}{Bucle principal}{Nota}{Recorre tots els elements}
for (int i = 0; i < n; i++) { ... }
\end{CodeBox}
```

### Entorn `CodeBox*`
Com `CodeBox` però pot trencar-se entre pàgines.

### `\pxCodeFile[opcions]{ruta}`
Inclou un fitxer de codi complet com a bloc `pxCode`.

```latex
\pxCodeFile[language=pxPython]{src/solver.py}
```

### `\pxCodeIn[opcions]{codi}[estil]`
Codi en línia (inline) dins del text.

```latex
El mètode \pxCodeIn{main()} és el punt d'entrada.
```

> **Avís: limitacions de `\pxCodeIn`**
>
> `\pxCodeIn` s'implementa sobre `\lstinline` i, per tant, **no és verbatim pur**. LaTeX processa l'argument en un mode especial que no protegeix tots els caràcters:
>
> - Els **caràcters actius** (`~` `\` `#` `%` `_` `^` `&`) i les **claus desbalancejades** dins de `\pxCodeIn{…}` trenquen la compilació amb errors típics com `Missing $ inserted` o `lstinline ended by EOL`.
> - Per a **rutes** que continguin algun d'aquests caràcters, usa `\texttt{\textasciitilde/ruta}` o bé `\path|~/ruta|` (paquet `url`) en lloc de `\pxCodeIn`.
> - `\pxCodeIn` **no parteix línies**: una cadena llarga (típicament una **URL**) desborda el marge dret (*overfull hbox*). Per a URLs o cadenes llargues usa `\url{...}` (parteix per `/` i `.`) en lloc de `\pxCodeIn`.
> - Reserva `\pxCodeIn` per a **identificadors simples** sense caràcters especials: `main()`, `latexmk`, `references.bib`.

---

## pxSRC — Imatges

### `\pxSRCsetup{claus}`
Configura les opcions globals: amplada per defecte, posició, etc.

### `\pxIMG[amplada]{nom-imatge}[color-placeholder]{peu}[etiqueta]`
Inclou una imatge de forma segura (mostra un placeholder de color si el fitxer no existeix).

- `amplada`: opcional, per defecte `.8\linewidth`
- `nom-imatge`: nom o ruta del fitxer (sense extensió si la detecció és automàtica)
- `color-placeholder`: color del rectangle de reserva si la imatge no existeix
- `peu`: text del peu de figura
- `etiqueta`: etiqueta per a `\ref` (auto-generada si s'omet)

```latex
\pxIMG[.6\linewidth]{diagrama-er}{Diagrama Entitat-Relació}[fig:er]
```

### `\pxIMGpair[amplada]{img-esq}{img-dret}[placeholder]{peu}[etiqueta]`
Dues imatges costat a costat.

```latex
\pxIMGpair{before}{after}{Comparació de rendiment}
```

### `\pxIMGList[amplada]{prefix}[placeholder]{peus-separats-per-comes}`
Sèrie d'imatges amb noms consecutius: `prefix1`, `prefix2`, etc.

```latex
\pxIMGList[.7\linewidth]{fig-}{%
  Primera captura,
  Segona captura,
  Tercera captura%
}
```

### Setters de valors per defecte (pxSRC)
| Comanda | Efecte |
|---|---|
| `\pxDEFimagewidth{amplada}` | Amplada per defecte de `\pxIMG` |
| `\pxDEFimagepairwidth{amplada}` | Amplada per defecte de `\pxIMGpair` |
| `\pxDEFimageplaceholdercolor{color}` | Color del placeholder |
| `\pxDEFimageposition{especificador}` | Posició del float (`H`, `h!`, etc.) |
| `\pxDEFimagepairgap{distància}` | Separació entre les dues imatges del parell |
| `\pxDEFimagelabelprefix{prefix}` | Prefix de les etiquetes auto-generades |

---

## pxUML — Diagrames UML

### `\pxUMLClass[*][tipus]{nom}[estereotip]{atributs}{operacions}[parents]<opcions-tikz>`
Defineix una classe UML (no la dibuixa, l'emmagatzema).

- `*`: visibilitat privada
- `tipus`: `class` (per defecte) | `interface` | `abstract`
- `nom`: identificador intern
- `estereotip`: text entre `«»` (opcional)
- `atributs`: llista separada per comes: `+edat:int, -nom:String`
- `operacions`: llista separada per comes: `+getNom():String`

```latex
\pxUMLClass{Persona}{+nom:String, +edat:int}{+getNom():String}
```

### `\addAttribute{nom-classe}{atribut}`
Afegeix un atribut a una classe ja definida.

### `\addOperation{nom-classe}{operació}`
Afegeix una operació a una classe ja definida.

### `\addInheritance{fill}{pare}`
Declara una relació d'herència entre classes.

### `\pxUMLAttributes{nom}`, `\pxUMLOperations{nom}`, `\pxUMLParents{nom}`
Imprimeix la llista d'atributs, operacions o pares d'una classe.

### `\drawclass[*][opcions]{nom}[posició]`
Dibuixa la classe dins d'un entorn `tikzpicture`. `*` aplica color de variació.

### `\drawsimpleclass[*][opcions]{nom}[posició]`
Dibuixa la classe sense compartiments (nom únicament).

### `\drawinstance[*][amplada]{nom}[posició]{classe}{atributs}[operacions]`
Dibuixa una instància UML.

### `\pxUMLDiagram[*][opcions tikz]{contingut}[amplada]<offset>`
Entorn complet per a un diagrama UML (envolta tikzpicture + redimensionat).

```latex
\pxUMLClass{Vehicle}{+matricula:String}{+arrancar():void}
\pxUMLClass{Cotxe}{+portes:int}{}
\addInheritance{Cotxe}{Vehicle}

\pxUMLDiagram{
  \drawclass{Vehicle}[0,0]
  \drawclass{Cotxe}[0,-3]
}
```

---

## pxPRP — Mapes de propietats

### `\pxNewObject{obj}` / `\NEW(obj)`
Crea (o assegura l'existència de) un objecte lògic.

```latex
\pxNewObject{persona}
% o bé:
\NEW(persona)
```

### `\pxSetValue{obj}{clau}{valor}` / `\SET(obj.clau)valor`
Estableix un valor escalar.

```latex
\pxSetValue{persona}{nom}{Maria}
\SET(persona.edat)25
```

### `\pxGetScalar{obj}{clau}` / `\GET(obj.clau)`
Recupera un valor escalar per imprimir-lo.

```latex
Nom: \pxGetScalar{persona}{nom}
Edat: \GET(persona.edat)
```

### `\pxPutValue{obj}{clau}{valor}`
Afegeix elements a una llista dins d'una clau.

### `\pxListSet{obj}{clau}{llista}` / `\pxListPutRight{obj}{clau}{element}` / `\pxListPutLeft{obj}{clau}{element}`
Gestiona llistes: establir tota la llista, afegir per la dreta o per l'esquerra.

### `\pxListAll{obj}{clau}[separador]`
Imprimeix tots els elements de la llista, separats pel separador indicat (per defecte `, `).

### `\pxListLen{obj}{clau}`
Retorna la longitud de la llista.

### `\pxListClear{obj}{clau}`
Buida la llista.

### `\pxClearKey{obj}{clau}` / `\pxClearObject{obj}`
Elimina una clau o tot l'objecte.

---

## pxGDX — Colors i utilitats de disseny

### Colors oficials UOC predefinits
| Nom | Hex aproximat | Descripció |
|---|---|---|
| `primaryColor` | `#000078` | Blau UOC oficial |
| `secondaryColor` | `#73EDFF` | Cian UOC oficial |
| `neutralColor` | — | Gris neutre |
| `darkColor` | — | Blau fosc |
| `lightColor` | — | Gris clar |
| `lighterColor` | `#FFFFFF` | Blanc |

Aquests colors s'apliquen directament amb `\textcolor{primaryColor}{...}` o com a opcions de clau en `\pxTABsetup`, `\PECTeXcover`, etc.

### `\pxGrow[*][factor]{contingut}[amplada-màx]`
Redimensiona el contingut per ocupar l'amplada especificada. `*` alinea a l'esquerra.

```latex
\pxGrow{\textbf{PAC1}}[.5\linewidth]
```

### `\pxFill`
Omple l'espai horitzontal restant (equivalent a `\hfill` optimitzat per P3CTeX).

### `\pxHRule[*][amplada]`
Línia horitzontal. `*` traça una línia gruixuda (1.5pt); sense `*`, línia fina (0.75pt). Amplada per defecte: `\linewidth`.

```latex
\pxHRule            % línia fina a tot l'ample
\pxHRule*           % línia gruixuda
\pxHRule[.5\linewidth]  % línia fina a mig ample
```

### `\pxPageRule[*]`
Línia decorativa de pàgina centrada (80% de l'ample, amb sagnat del 10%).
