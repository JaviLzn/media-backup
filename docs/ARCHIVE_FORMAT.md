# Formato del respaldo v1

Contrato propuesto; debe validarse antes de declarar estable la versión.

```text
MediaBackup/
  archive.json
  Originals/
    2022/
      02/
        <asset-uuid>/
          001-original.HEIC
          002-paired.MOV
    Undated/
  Catalog/
    assets.jsonl
  Verification/
    SHA256SUMS.txt
    sessions/
      <session-uuid>.json
  Thumbnails/   # opcional
  .staging/     # temporales
```

| Archivo | Contenido |
|---|---|
| archive.json | Versión, ID de archivo y fecha de creación. |
| assets.jsonl | ID propio estable por elemento, fecha UTC o nula, zona de organización, tipo, metadatos disponibles, recursos y asociaciones. |
| Recursos | ID, rol, UTI, nombre original, ruta relativa, tamaño en bytes, SHA-256, estado y fecha de verificación. |
| SHA256SUMS.txt | Sumas estándar de recursos verificados, rutas relativas a la raíz. |
| Informe de sesión | Selección, zona, permisos, inventario, resultados, errores, cambios, fecha y hash del catálogo y sumas correspondientes. |

Los recursos faltantes se registran sin hashes ficticios. Distinguir nulo/desconocido de cero. Los identificadores PhotoKit son referencias locales, no universales. Nombres de almacenamiento resistentes a colisiones; conservar nombre original en catálogo.

## Escritura y recuperación
- Escribir temporal en el SSD, completar lectura de origen, cerrar, verificar temporal, mover sin sobrescribir, releer archivo final y confirmar catálogo. Registrar operaciones para reconciliar interrupciones; excluir temporales de sumas e informes de éxito.
- Validar rutas relativas, no seguir enlaces simbólicos externos y no permitir escrituras simultáneas incompatibles. No prometer atomicidad física universal de exFAT; reverificar tras reconexión.
- Respaldos ajenos: indexar sin alterar; incorporar recursos verificados al archivo gestionado cuando sea necesario para que sea autosuficiente.
- El catálogo portable es fuente de recuperación; índices y miniaturas locales son caché reconstruible. Si el catálogo falla, los originales siguen accesibles manualmente.
- Conservar recursos y metadatos de biblioteca por separado, sin modificar bytes originales. Los hashes no autentican un archivo frente a un atacante que también reescribe el manifiesto.
