# Actualiza en README.md los enlaces reales de YouTube y los ejercicios precargados.
# 1. Edita scripts/video-links.csv y pega los enlaces de 8 videos y 8 ejercicios.
# 2. Ejecuta desde la raiz del repo:
# powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\Actualizar-Enlaces.ps1
# No crea commits ni publica cambios; debes revisar el diff antes de registrarlos.
param([string]$ProjectRoot = (Split-Path -Parent $PSScriptRoot))
$ErrorActionPreference = 'Stop'
$csvPath = Join-Path $ProjectRoot 'scripts/video-links.csv'
$readmePath = Join-Path $ProjectRoot 'README.md'
if (!(Test-Path $csvPath) -or !(Test-Path $readmePath)) { throw 'No se encontraron el CSV y/o README.md.' }
$rows = @(Import-Csv -LiteralPath $csvPath -Encoding UTF8)
if ($rows.Count -ne 8) { throw 'El CSV debe tener exactamente 8 lecciones.' }
$content = [IO.File]::ReadAllText($readmePath,[Text.Encoding]::UTF8)
$changes = 0
foreach ($r in $rows) {
    if ($r.lesson -notmatch '^0[1-8]$') { throw "Numero de leccion no valido: $($r.lesson)" }
    foreach ($type in @('video_url','editor_url')) {
        $mark = if ($type -eq 'video_url') { "PENDIENTE_VIDEO_$($r.lesson)" } else { "PENDIENTE_EDITOR_$($r.lesson)" }
        $url = [string]$r.$type
        if ($url.StartsWith('PENDIENTE_') -or [string]::IsNullOrWhiteSpace($url)) { continue }
        if ($url -notmatch '^https://[^\s<>\)]+$') { throw "URL invalida en leccion $($r.lesson): $url" }
        if ($type -eq 'video_url' -and $url -notmatch '^https://(www\.)?(youtube\.com|youtu\.be)/') { throw "Se esperaba un enlace de YouTube para $($r.lesson)" }
        if ($type -eq 'editor_url' -and $url -match '^https://(www\.)?(jdoodle\.com/online-java-compiler|onlinegdb\.com/online_java_compiler)/?$') { throw "El enlace de editor de $($r.lesson) debe abrir el codigo ya precargado, no solo la pagina principal." }
        if ($content.Contains($mark)) { $content=$content.Replace($mark,$url);$changes++ }
    }
}
if ($changes -gt 0) {
    [IO.File]::WriteAllText($readmePath,$content,(New-Object System.Text.UTF8Encoding($false)))
}
Write-Host "Enlaces actualizados: $changes" -ForegroundColor Green
Write-Host 'Revisa README.md y ejecuta git diff antes de crear un commit.'