# Requisitos — iPhone y SSD

Objetivo: respaldar una selección de la fototeca iOS en un SSD conectado al iPhone, demostrar integridad y completitud, y recuperar elementos en Fotos. Aplicación gratuita, sin publicidad, cuenta propia, servidor ni telemetría.

## Requisitos funcionales

| ID | Requisito |
|---|---|
| MB-01 | Distinguir permiso Fotos completo, limitado o denegado. Seleccionar carpeta SSD mediante Archivos; comprobar acceso, escritura y capacidad cuando esté disponible. |
| MB-02 | Filtrar por año, mes, rango de fechas, todo, fotos/videos y selección individual o múltiple. Usar fecha de captura, calendario/zona declarados e intervalo inicio inclusivo/fin exclusivo. Mostrar elementos sin fecha aparte y cantidades/bytes conocidos; identificar estimaciones. |
| MB-03 | Escanear recursivamente respaldos existentes, incluso sin catálogo, en solo lectura. Detectar faltantes, archivos renombrados, duplicados y diferencias mediante tamaño y SHA-256; nombres y fechas solo orientan la búsqueda. No confundir archivos convertidos con originales. |
| MB-04 | Inventariar cada recurso de un elemento: foto, video, Live Photo, RAW/JPEG y recursos de edición disponibles. Registrar nombre, tipo, fecha, ubicación, favoritos y álbumes cuando accesibles. Preservar EXIF y demás metadatos embebidos manteniendo los bytes originales. |
| MB-05 | Copiar los recursos seleccionados al SSD sin recomprimir, transcodificar ni sobrescribir archivos existentes. Reutilizar recursos verificados y no duplicarlos en ejecuciones sucesivas. |
| MB-06 | Contar bytes y calcular SHA-256 del flujo original completo; cerrar y releer independientemente el archivo final del SSD. Solo verificar si la lectura de origen terminó correctamente y ambos tamaños y hashes coinciden. Permitir reverificar tras reconectar el SSD. |
| MB-07 | Generar estructura por año/mes, catálogo, manifiesto de recursos y sumas SHA-256 portables según ARCHIVE_FORMAT.md. Recuperación sin depender de la instalación original de la app. |
| MB-08 | Mostrar progreso, cancelación y reanudación por recurso. Recuperar interrupciones, disco lleno, desconexión, permisos revocados y cierre de app sin perder confirmaciones válidas ni declarar éxitos falsos. No exigir ejecución continua en segundo plano. |
| MB-09 | Informar completitud de la selección: elementos/recursos esperados, verificados, faltantes, parciales, diferentes, inaccesibles, pendientes y errores. Reconciliar cambios de la fototeca durante el trabajo. Un año solo se declara completo respecto del inventario accesible, sin pendientes ni incertidumbres de alcance. |
| MB-10 | Explorar el archivo histórico desde SSD: años/meses, búsqueda por nombre, fecha y tipo, miniaturas opcionales, vista de fotos y reproducción de videos compatibles. Reconstruir catálogo tras reinstalación o cambio de iPhone. |
| MB-11 | Restaurar uno, varios o todos los elementos de una selección/período en Fotos. Verificar recursos antes de importar, conservar SSD intacto, aplicar metadatos compatibles y evitar duplicación silenciosa al reintentar. |
| MB-12 | Comprobar resultado de restauración: identificar nuevo elemento, reexportar recursos y comparar tamaño/hash y metadatos cuando sea posible. Diferenciar importado de restaurado y verificado; informar cualquier limitación. No prometer mismo identificador Apple, historial de edición o reconocimiento facial. |
| MB-13 | Auditar catálogo, rutas, asociaciones, hashes y archivos faltantes, extra, huérfanos, ilegibles o modificados. Exportar informe por período. |
| MB-14 | Mantener archivos legibles fuera de la app, sin formato propietario. Operaciones locales sin internet; recursos disponibles únicamente en iCloud requieren descarga autorizada o estado pendiente. No acceder fuera de carpetas autorizadas. |

## Criterios de aceptación

- AC-01 (MB-01/02): seleccionar 2022 incluye solo fechas del intervalo definido, con filtros de tipo y selección. Permiso limitado impide certificar toda la biblioteca; fechas desconocidas se informan.
- AC-02 (MB-03/05/06): detectar original renombrado; rechazar mismo tamaño con bytes distintos y video transcodificado. Repetir backup sin duplicar.
- AC-03 (MB-04/09/14): Live Photo sin recurso asociado, RAW incompleto o recurso iCloud no accesible impiden declarar elemento completo.
- AC-04 (MB-05/06/08): copiar y verificar video >4 GiB con memoria acotada; simular cancelación, disco lleno y desconexión; reanudar sin sobrescribir ni marcar temporales como verificados.
- AC-05 (MB-07/13/14): detectar corrupción de un byte, ruta maliciosa, catálogo inválido, recurso ausente y archivos extra; validar SHA-256 con una herramienta independiente.
- AC-06 (MB-10/14): conectar SSD a otro iPhone o reinstalar; reconstruir catálogo y explorar 2022 sin datos locales previos.
- AC-07 (MB-11/12): restaurar foto, video, Live Photo y RAW compatible; comprobar bytes y metadata soportada; SSD sin cambios.
- AC-08 (MB-11/12): restaurar selección múltiple/año; registrar cada resultado; reintentar sin duplicar silenciosamente; manejar falta de espacio o permisos.
- AC-09 (MB-09/13): reconciliar cambios de fototeca; informe con selección, fecha, autorización, inventario y errores. No certificar años con recursos pendientes.
- AC-10 (MB-14): validar SSD físico exFAT, permisos, reconexión y ausencia de escrituras fuera de la carpeta autorizada.

## Límites
No eliminar originales del iPhone en la primera versión. El informe acredita la comprobación en un instante, no la conservación futura; recomendar otra copia independiente antes de eliminar manualmente. No prometer restauración exacta de propiedades de Fotos que Apple no expone. Interfaz inicial en español y accesible.
