# Inserta en el plan del curso los enlaces de YouTube y de las prácticas compartidas.
# Completa scripts/video-links.csv y ejecuta este archivo desde el repositorio.
param([string]$ProjectRoot = (Split-Path -Parent $PSScriptRoot))
$ErrorActionPreference = 'Stop'

$csvFile = Join-Path $ProjectRoot 'scripts/video-links.csv'
$readmeFile = Join-Path $ProjectRoot 'README.md'
if (-not (Test-Path -LiteralPath $csvFile) -or -not (Test-Path -LiteralPath $readmeFile)) {
    throw 'No se encontraron README.md y scripts/video-links.csv.'
}

$rows = @(Import-Csv -LiteralPath $csvFile -Encoding UTF8)
if ($rows.Count -ne 8) { throw 'Deben existir ocho filas, una por leccion.' }
$text = [System.IO.File]::ReadAllText($readmeFile, [System.Text.Encoding]::UTF8)
$changes = 0

foreach ($row in $rows) {
    $id = [string]$row.lesson
    if ($id -notmatch '^0[1-8]$') { throw "Numero de leccion incorrecto: $id" }
    $number = [int]$id
    $videoUrl = ([string]$row.video_url).Trim()
    $editorUrl = ([string]$row.editor_url).Trim()
    $newLinks = @()

    if ($videoUrl -ne '') {
        if ($videoUrl -notmatch '^https://(www\.)?(youtube\.com|youtu\.be)/\S+$') {
            throw "La URL del video de la leccion $id no es de YouTube."
        }
        $newLinks += "**Video:** [Ver la leccion $number]($videoUrl)"
    }
    if ($editorUrl -ne '') {
        if ($editorUrl -notmatch '^https://\S+$') { throw "La URL del ejercicio de la leccion $id no es valida." }
        $newLinks += "**Ejercicio en linea:** [Abrir la practica]($editorUrl)"
    }
    if ($newLinks.Count -eq 0) { continue }

    $heading = [regex]::Match($text, "(?m)^### Lección $number\..*$")
    if (-not $heading.Success) { throw "No se encontro la leccion $number en el README." }
    $start = $heading.Index + $heading.Length
    $next = [regex]::Match($text.Substring($start), '(?m)^##(?:#)? ')
    $end = if ($next.Success) { $start + $next.Index } else { $text.Length }
    $section = $text.Substring($start, $end - $start)

    if ($videoUrl -ne '') {
        $section = [regex]::Replace($section, '(?m)^\*\*Video:\*\*[^\r\n]*\r?\n?', '')
    }
    if ($editorUrl -ne '') {
        $section = [regex]::Replace($section, '(?m)^\*\*Ejercicio en línea:\*\*[^\r\n]*\r?\n?', '')
        $section = [regex]::Replace($section, '(?m)^\*\*Ejercicio en linea:\*\*[^\r\n]*\r?\n?', '')
    }

    $section = $section.TrimEnd() + "`n`n" + ($newLinks -join "`n") + "`n`n"
    $text = $text.Substring(0, $start) + $section + $text.Substring($end)
    $changes += $newLinks.Count
}

if ($changes -gt 0) {
    [System.IO.File]::WriteAllText($readmeFile, $text, (New-Object System.Text.UTF8Encoding($false)))
}
Write-Host "Enlaces incorporados o actualizados: $changes" -ForegroundColor Green
Write-Host 'Revisa README.md antes de publicar los cambios.'
