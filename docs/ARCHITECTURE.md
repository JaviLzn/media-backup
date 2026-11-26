# Arquitectura

## ADR-001 — Swift nativo
SwiftUI + PhotoKit + UniformTypeIdentifiers/UIDocumentPicker y URLs security-scoped. Swift Package Manager para lógica independiente de Apple y XcodeGen para el proyecto iOS generado. Windows compila el core; GitHub Actions compila iOS en macOS. No usar Flutter, React Native ni VM como requisito inicial.

## Límites de componentes
- Sources/BackupCore: modelos, reglas de comparación, manifiestos, estado y pruebas portables.
- iOS: adaptadores PhotoKit, acceso autorizado a carpetas externas, UI y CryptoKit. Aislar dependencias Apple del core.
- Persistencia SQLite propuesta tras validar el dispositivo; no introducirla en la prueba de concepto.
- Hashing por bloques. Mantener acceso security-scoped durante operaciones, liberar después, no seguir enlaces simbólicos fuera del destino.
- Copia futura: escribir temporal, comprobar tamaño y hash leyendo destino, mover dentro del mismo volumen sin sobrescribir, actualizar manifiesto solo tras éxito. Recuperar temporales e interrupciones sin declarar falsos éxitos.
- Manifiesto futuro: versión, ID local del elemento (no identificador universal), tipo de recurso, nombre original, tamaño, SHA-256, ruta relativa, fechas y metadatos disponibles, estado, fecha de verificación. Validar rutas y rechazar traversal.
- SHA-256 comprueba igualdad de bytes en el momento de lectura, no inmunidad a fallos futuros. Recomendar segunda copia independiente y comprobaciones periódicas.

## Distribución
IPA sin firma generado como artefacto manual en CI; firma personal fuera de GitHub. No almacenar Apple ID ni claves de firma. App Store requiere evaluar costos y términos de distribución por separado.
