# Media Backup

Herramienta pública y gratuita para verificar y respaldar fotos y videos de iPhone en almacenamiento externo, sin servidor ni suscripción.

**Estado: 0.0.0 — prueba de concepto, no apta aún para borrar originales.**

## Desarrollo desde Windows
1. Instalar Swift y sus prerrequisitos según https://www.swift.org/install/windows/winget/.
2. Instalar Git, GitHub CLI y VS Code con la extensión Swift.
3. Clonar el repositorio y ejecutar `powershell -File scripts/bootstrap.ps1` y `swift test`.
4. Autenticarse con `gh auth login`; ejecutar `gh workflow run build-ios.yml --ref main`.
5. Consultar `gh run list --workflow build-ios.yml`, ejecutar `gh run watch <ID>` y descargar con `gh run download <ID> -n media-backup-unsigned -D dist`.
6. Firmar e instalar el IPA con una herramienta de sideload de confianza, por ejemplo Sideloadly. La firma gratuita suele caducar en siete días; no es una distribución App Store.

La prueba de concepto consulta la autorización de Fotos y permite seleccionar una carpeta, enumerar sus archivos directos y calcular SHA-256 del primer archivo regular. No escribe ni borra datos.

## Documentación
- [Requerimientos](docs/REQUIREMENTS.md)
- [Arquitectura](docs/ARCHITECTURE.md)
- [Referencias y licencias](docs/REFERENCES.md)
- [Roadmap](docs/ROADMAP.md)
- [Handoff](docs/HANDOFF.md)

Licencia Apache-2.0. No se han incorporado fuentes de terceros en este inicio.
