# Handoff para Claude Code

Estado inicial: repositorio público, Apache-2.0 existente, rama main. Se propone una PoC de lectura, un core portable pequeño y CI manual; no se ha ejecutado la compilación ni validado un iPhone.

Siguiente acción:
1. Clonar main, ejecutar scripts/bootstrap.ps1 y swift test desde Windows; corregir cualquier fallo y registrar versiones.
2. Ejecutar workflow build-ios.yml, revisar logs, corregir errores y descargar IPA.
3. Instalar con firma personal y verificar en iPhone real la autorización Fotos, selección de SSD y SHA-256 contrastado con Get-FileHash -Algorithm SHA256 en Windows.
4. Auditar Watermelon y demás referencias, fijando commit y licencia. Decidir reutilización por archivo, no por suposición.
5. Implementar fase 2 solo después de validar la PoC. Crear fixtures sintéticos y pruebas adversas.

El borrado no está implementado ni autorizado. No introducir secretos ni datos personales. Mantener una lista de pendientes y resultados verificables.
