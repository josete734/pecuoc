# Changelog

## [0.3.0] - 2026-06-08
### Added
- Linter pre-compilación `scripts/lint-tex.sh`: detecta `\bigskip\\`, `\pxCodeIn` con
  caracteres activos y títulos `.bib` con comandos sin proteger.
### Changed
- Verificación de páginas robusta con cadena de alternativas pdfinfo → mdls → recuento
  de `[N]` en el `.log` (en `scripts/verify.sh`, el subagente y las referencias), en vez
  de depender solo de pdfinfo.
### Docs
- Documentadas las trampas de `\pxCodeIn` (no es verbatim) y la protección con llaves de
  los títulos `.bib`, en las referencias, la skill y el subagente.
- README actualizado: badge 0.3.0 y flujo de instalación con enable + reinicio de sesión.

## [0.2.1] - 2026-06-08
### Fixed
- El plugin no cargaba (`Duplicate hooks file detected`): se elimina la clave `hooks`
  del `plugin.json`. Claude Code ya carga `hooks/hooks.json` automáticamente, así que
  `manifest.hooks` solo debe referenciar archivos de hooks adicionales.

## [0.2.0] - 2026-06-05
### Fixed
- `/pecuoc:setup` ya no depende de `${CLAUDE_PLUGIN_ROOT}` (no se expande en el cuerpo de
  un command/skill): ahora localiza `install.sh` en la caché de plugins de forma robusta.
### Added
- `allowed-tools: Bash` en el command de setup para una instalación sin fricción.
- Carpeta `examples/POO/` con una PAC completa de ejemplo (compila limpia).
- README rediseñado: badges, inicio rápido, tabla de características y secciones claras.
- Topics del repositorio en GitHub.

## [0.1.0] - 2026-06-05
### Added
- Plugin inicial: skill `pecuoc-author`, subagente `pecuoc-author`, command `/pecuoc:setup`.
- Autoinstalador macOS (clona P3CTeX, registra en TEXMFHOME, verifica).
- Hook SessionStart que avisa si falta el setup.
- Cheatsheets px* verificados y referencia de identidad visual oficial UOC.
- Plantillas minimal y extended.
