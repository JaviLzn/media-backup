# Arquitectura

Swift nativo: SwiftUI, PhotoKit, selector de carpetas iOS y CryptoKit. Core portable mediante Swift Package Manager, proyecto iOS generado con XcodeGen. Desarrollo Windows; compilación macOS en GitHub Actions; pruebas finales en iPhone físico.

| Componente | Responsabilidad |
|---|---|
| BackupCore | Selección temporal, modelos, comparación, estados, manifiestos y validación de rutas; pruebas portables. |
| PhotoLibraryAdapter | Autorización, inventario PHAsset/PHAssetResource, streaming original y reconciliación; descarga iCloud autorizada si se requiere. |
| ExternalStorageAdapter | Carpeta seleccionada, security-scoped URLs, coordinación de archivos, capacidad, lectura/escritura segura. |
| BackupEngine | Cola persistente por recurso, hash incremental, copia temporal, relectura, confirmación y reanudación. |
| ArchiveRepository | Contrato ARCHIVE_FORMAT.md, índices, informes y caché reconstruible. |
| RestoreEngine | Preflight, verificación, PHAssetCreationRequest sin mover el original, metadatos y validación posterior. |
| UI | Respaldar, Comparar, Explorar, Restaurar, Verificar. |

Procesamiento por bloques y concurrencia acotada; ningún video completo en RAM. Preferir exFAT para SSD interoperable, previa validación física. No formatear automáticamente. SQLite opcional como caché, nunca requisito de recuperación.

IPA sin firma en CI manual, firma personal fuera de GitHub. No almacenar credenciales ni datos privados. Véase REQUIREMENTS.md para alcance y aceptación.
