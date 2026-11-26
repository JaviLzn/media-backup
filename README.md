# Media Backup

Aplicación iOS gratuita y de código abierto para archivar fotos y videos en un SSD externo, comprobar su integridad y restaurarlos en Fotos.

**Estado 0.0.0:** prueba de concepto de lectura. El respaldo y la restauración aún no están implementados.

## Alcance
- Respaldar por año, mes, fechas o selección.
- Reconocer respaldos existentes y copiar únicamente recursos faltantes.
- Preservar originales y metadatos, verificar SHA-256 y generar un catálogo portable.
- Explorar y restaurar archivos desde el SSD, incluso en otro iPhone.

## Desarrollo
Windows + Swift + VS Code; compilación iOS mediante GitHub Actions.
1. Instalar Swift según https://www.swift.org/install/windows/winget/, Git y GitHub CLI.
2. Clonar el repositorio, ejecutar `powershell -File scripts/bootstrap.ps1` y `swift test`.
3. Ejecutar `gh workflow run build-ios.yml --ref main`; consultar `gh run list --workflow build-ios.yml`.
4. Descargar con `gh run download <ID> -n media-backup-unsigned -D dist`.
5. Firmar e instalar el IPA personalmente; la firma gratuita suele vencer en siete días.

## Documentación
- [Requisitos y aceptación](docs/REQUIREMENTS.md)
- [Formato del respaldo](docs/ARCHIVE_FORMAT.md)
- [Arquitectura](docs/ARCHITECTURE.md)
- [Referencias](docs/REFERENCES.md)
- [Roadmap](docs/ROADMAP.md)
- [Handoff](docs/HANDOFF.md)

Licencia Apache-2.0.
