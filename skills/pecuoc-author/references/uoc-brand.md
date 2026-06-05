# Identitat visual UOC en P3CTeX

## Colors oficials

| Nom P3CTeX | Hex (aprox.) | CMYK / RGB | Nom oficial UOC |
|---|---|---|---|
| `primaryColor` | `#000078` | RGB(0, 0, 120) | Blau UOC principal |
| `secondaryColor` | `#73EDFF` | RGB(115, 237, 255) | Cian UOC |
| `neutralColor` | `#787878` | CMYK(50,14,16,0) | Gris neutre |
| `darkColor` | — | RGB(26, 64, 128) | Blau fosc |
| `lightColor` | `#828282` | CMYK(0,0,0,30) | Gris clar |
| `lighterColor` | `#FFFFFF` | RGB(255, 255, 255) | Blanc |

> **P3CTeX ja usa els colors oficials UOC** per a les portades, capçaleres i peus de pàgina. No cal redefinir-los ni sobreescriure'ls en condicions normals.

Referència de color per a les opcions de portada i taules:
```latex
% Exemple: taula amb capçalera en blau UOC
\pxTABsetup{style=header, headerbgcolor=primaryColor, headertextcolor=lighterColor}

% Exemple: text en cian UOC
\textcolor{secondaryColor}{text destacat}
```

---

## Tipografia oficial UOC

| Context | Font |
|---|---|
| Documents Word | Georgia |
| Presentacions PowerPoint | Arial |
| P3CTeX (LaTeX) | Arev (sans-serif, carregada automàticament per la classe) |

P3CTeX carrega `arev` automàticament; no cal afegir cap paquet de fonts addicional.

---

## Logotip UOC

El logotip de la UOC és una **marca registrada** i no es distribueix dins de P3CTeX per raons de llicència.

Si tens accés als recursos oficials de la UOC (p. ex., a través del Campus Virtual o de l'arxiu `Office-UOC-Generic.zip`):

1. Extreu el fitxer del logo (normalment `logo_uoc.png` o similar).
2. Col·loca'l a `~/.pecuoc/assets/` o a la carpeta `img/` del teu document.
3. Referencia'l des del document:

```latex
% Com a imatge en el cos del document:
\pxIMG[3cm]{img/logo_uoc}{Logotip UOC}

% Com a imatge principal de la portada:
\PECTeXcover{
  add-picture,
  set-mainpicture = {img/logo_uoc}
}
```

---

## Aplicació dels colors en documents

### Portada
```latex
\PECTeXcover{
  maincolor  = secondaryColor,   % fons de la banda principal (default)
  textcolor  = primaryColor,     % color del text principal (default)
  auxcolor   = lightColor        % color auxiliar (default)
}
```

### Taules
```latex
% Preset de capçalera amb colors UOC (predefinit com 'p3c-header')
\pxTABusepreset{p3c-header}
% Equivalent manual:
\pxTABsetup{
  style          = header,
  headerbgcolor  = primaryColor,
  headertextcolor = lighterColor,
  headerfont     = \sffamily\bfseries
}
```

### Regles i separadors
```latex
\pxHRule        % línia fina de color del document
\pxHRule*       % línia gruixuda (1.5pt)
```
