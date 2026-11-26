# Media Backup

Aplicación iOS gratuita y de código abierto para archivar fotos y videos en un SSD externo, comprobar su integridad y restaurarlos en Fotos.

**Estado 0.0.0:** prueba de concepto de lectura. El respaldo y la restauración aún no están implementados.

## Alcance
- Respaldar por año, mes, fechas o selección.
- Reconocer respaldos existentes y copiar únicamente recursos faltantes.
- Preservar originales y metadatos, verificar SHA-256 y generar un catálogo portable.
- Explorar y restaurar archivos desde el SSD, incluso en otro iPhone.

## Desarrollo
Stack: Swift nativo. `BackupCore` es un paquete SwiftPM (se prueba en Windows) y la app SwiftUI en `iOS/` se compila en GitHub Actions (macOS) porque no hay Mac. No hay Expo ni web: la app se instala en el iPhone como IPA.

### Windows (núcleo y pruebas)
1. Instalar Git y GitHub CLI (`gh auth login`).
2. Instalar Swift según https://www.swift.org/install/windows/winget/. Requiere Visual Studio con el componente *MSVC x64/x86* y el *Windows 11 SDK* (pide permisos de administrador):
   ```powershell
   winget install --id Swift.Toolchain -e
   ```
3. Desde la raíz: `powershell -File scripts/bootstrap.ps1` y luego `swift test`.

### Compilar el IPA (GitHub Actions)
1. `gh workflow run build-ios.yml --ref <rama>` (el workflow es manual; repo público, minutos de macOS gratis).
2. `gh run list --workflow build-ios.yml` para ver el ID y `gh run watch <ID>` para seguirlo (~2 min).
3. `gh run download <ID> -n media-backup-unsigned -D dist` descarga `MediaBackup.ipa` y su `.sha256`. El artifact dura 7 días.

### Instalar en el iPhone desde Windows (Apple ID gratis)
1. Instalar iTunes e iCloud de apple.com (no la versión de Microsoft Store) y Sideloadly desde https://sideloadly.io.
2. Conectar el iPhone por cable, desbloquearlo y aceptar «Confiar en este ordenador».
3. En Sideloadly: arrastrar `dist/MediaBackup.ipa`, escribir el Apple ID y pulsar *Start*. Usar un Apple ID secundario si es posible.
4. En el iPhone: *Ajustes → General → VPN y gestión de dispositivos → [Apple ID] → Confiar*. En iOS 16+ activar *Ajustes → Privacidad y seguridad → Modo de desarrollador* y reiniciar.
5. La firma gratuita vence a los **7 días**: hay que reinstalar con Sideloadly (no se pierden los datos si se reinstala encima). Máximo 3 apps firmadas a la vez con Apple ID gratis.

## Documentación
- [Requisitos y aceptación](docs/REQUIREMENTS.md)
- [Formato del respaldo](docs/ARCHIVE_FORMAT.md)
- [Arquitectura](docs/ARCHITECTURE.md)
- [Referencias](docs/REFERENCES.md)
- [Roadmap](docs/ROADMAP.md)
- [Handoff](docs/HANDOFF.md)

Licencia Apache-2.0.
