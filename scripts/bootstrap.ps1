$ErrorActionPreference = 'Stop'
foreach ($tool in @('git', 'gh', 'swift')) {
    if (-not (Get-Command $tool -ErrorAction SilentlyContinue)) {
        throw "Falta $tool. Consulta https://www.swift.org/install/windows/winget/ y README.md."
    }
    & $tool --version
    if ($LASTEXITCODE -ne 0) { throw "No se pudo comprobar $tool" }
}
Write-Host 'Entorno detectado. Ejecuta swift test desde la raíz del repositorio.'
