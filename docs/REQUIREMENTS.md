# Requerimientos v0.0.0

## Objetivo
Herramienta iOS local-first, gratuita, abierta y sin telemetría, que identifique cuáles fotos y videos de la fototeca ya están respaldados en un SSD existente y cuáles faltan. Debe preservar originales y metadatos y permitir comprobar recuperabilidad sin depender de un formato propietario.

## Alcance
- MVP: permiso de lectura PhotoKit (distinguir limitado, completo, denegado), seleccionar carpeta SSD mediante document picker, inventariar recursivamente con errores explícitos, comparar recursos originales por SHA-256 y tamaño, exportar informe y manifiesto portátil JSON versionado.
- Considerar Live Photos, RAW+JPEG, videos grandes, ediciones y originales, archivos únicamente en iCloud, duplicados, nombres Unicode, colisiones y almacenamiento desconectado. No confundir PHAsset con archivo: cada elemento puede requerir varios recursos.
- Mostrar estados verificado, faltante, diferente, parcial, no accesible, pendiente iCloud y error. Coincidencias por nombre/fecha/tamaño son solo candidatos.
- Siguientes fases: copia incremental con temporal y verificación posterior, restauración comprobada, Google Drive opcional e interoperabilidad rclone/Windows. El borrado queda fuera del MVP y exige aprobación posterior y confirmación explícita.
- No prometer conservación de álbumes, ajustes o metadatos de biblioteca hasta definir y probar un formato para esos datos. Preservar bytes de originales y registrar metadatos de biblioteca por separado.
- No servidor, cuenta propia, anuncios, suscripción ni telemetría. No acceder fuera de las carpetas autorizadas.

## Criterios de aceptación (Gherkin)
- Dado un archivo de origen y un respaldo de bytes idénticos, cuando ambos SHA-256 y tamaños coinciden, entonces se marca el recurso como verificado.
- Dado un archivo con mismo nombre y tamaño pero bytes diferentes, cuando se compara, entonces no se marca verificado.
- Dada una Live Photo con video asociado ausente, cuando se evalúa el conjunto, entonces el elemento queda parcial.
- Dado un SSD desconectado o permiso revocado, cuando se interrumpe la lectura, entonces no se marca verificado y el usuario recibe un error recuperable.
- Dado permiso limitado a la fototeca, cuando se genera un informe, entonces se señala explícitamente que no cubre toda la biblioteca.
- Dado un original en iCloud no disponible, cuando no puede recuperarse, entonces el estado es pendiente/no accesible y jamás se autoriza un borrado.
- Dado un video de varios GB, cuando se calcula su hash, entonces se procesa por bloques sin cargarlo completo en memoria.
- Dado un archivo respaldado, cuando se valida en Windows, entonces el manifiesto permite repetir la comprobación SHA-256 sin la app.
- Dado un iPhone físico y SSD compatible, cuando se ejecuta la prueba de concepto, entonces la selección, lectura y hash funcionan sin modificar el SSD.
