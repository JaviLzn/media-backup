# Handoff

Estado 0.0.0: PoC de lectura que cuenta elementos visibles de Fotos, enumera archivos directos de una carpeta y calcula SHA-256 de un archivo. No implementa filtros, copia, catálogo ni restauración. Compilación iOS verificada en CI; prueba física pendiente.

## Evidencia (hito 0)
- 2026-11-25 · build-ios.yml run 45740793839 (macos-26): `swift test`, xcodegen y `xcodebuild` sin firma OK; IPA 37 810 bytes, SHA-256 `43d66463a313c1f3a8ad3fb60643b031ccd1eadba65419ceec16e0bd2b6d0100`, verificado tras descarga en Windows.
- Windows: Swift no instalado; Visual Studio 2026 sin MSVC ni Windows SDK. La instalación requiere aprobación de administrador (UAC) del dueño. `swift test` local pendiente.
- Sideloadly vía winget falló por hash del instalador; instalar desde sideloadly.io.

## Siguiente tarea
1. Instalar MSVC + Windows SDK + Swift (UAC), ejecutar bootstrap y swift test en Windows; registrar resultado.
2. Instalar el IPA con Sideloadly en el iPhone físico y registrar resultado.
3. Validar hito 1 con fixtures en iPhone y SSD físico; contrastar SHA-256 de forma independiente.
4. Auditar referencias y avanzar según ROADMAP.md, dejando evidencia por requisito y criterio de aceptación.

Actualizar este archivo tras cada unidad de trabajo con resultados reales, pendientes y bloqueos. No habilitar borrado de originales.
