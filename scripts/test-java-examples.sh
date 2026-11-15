#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

export LANG=C.UTF-8
export LC_ALL=C.UTF-8

for tool in java javac timeout; do
  if ! command -v "$tool" >/dev/null 2>&1; then
    echo "ERROR: Falta $tool"
    exit 1
  fi
done

TEMP="$(mktemp -d)"
trap 'rm -rf "$TEMP"' EXIT

LESSONS=(
  lesson-01-hello-world
  lesson-02-variables
  lesson-03-control-flow
  lesson-04-methods-input
  lesson-05-classes-objects
  lesson-06-encapsulation
  lesson-07-arrays-strings
  lesson-08-final-project
)

TOTAL=0

echo "=== COMPILACION DE LOS 16 ARCHIVOS JAVA ==="

for lesson in "${LESSONS[@]}"; do
  for folder in starter-files completed-examples; do
    SOURCE="$ROOT/$folder/$lesson/Main.java"
    DEST="$TEMP/$folder/$lesson"

    if [[ ! -f "$SOURCE" ]]; then
      echo "ERROR: No existe $SOURCE"
      exit 1
    fi

    mkdir -p "$DEST"
    javac -encoding UTF-8 -d "$DEST" "$SOURCE"

    TOTAL=$((TOTAL + 1))
    echo "OK: $folder/$lesson"
  done
done

run() {
  local lesson="$1"
  local input="${2-}"
  local directory="$TEMP/completed-examples/$lesson"

  if [[ -n "$input" ]]; then
    printf '%s' "$input" |
      timeout 20s java -Dfile.encoding=UTF-8 -cp "$directory" Main
  else
    timeout 20s java -Dfile.encoding=UTF-8 -cp "$directory" Main
  fi
}

check() {
  local output="$1"
  local expected="$2"
  local title="$3"

  if [[ "$output" == *"$expected"* ]]; then
    echo "OK: $title"
  else
    echo "FALLO: $title"
    echo "Resultado esperado: $expected"
    echo "Resultado obtenido:"
    printf '%s\n' "$output"
    exit 1
  fi
}

echo
echo "=== PRUEBAS FUNCIONALES ==="

# Lección 1

OUT="$(run lesson-01-hello-world)"
check "$OUT" "mi primer programa en Java" "L01 Hola Mundo"
check "$OUT" "Hoy voy a aprender" "L01 Segundo mensaje"

# Lección 2

OUT="$(run lesson-02-variables)"
check "$OUT" "Nombre: Ana" "L02 String"
check "$OUT" "Edad: 15" "L02 int"
check "$OUT" "Promedio: 16.5" "L02 double"
check "$OUT" "Puntos ganados: 5" "L02 operadores"

# Lección 3

OUT="$(run lesson-03-control-flow)"
check "$OUT" "Aprobado" "L03 if"
check "$OUT" "Práctica 3" "L03 for"
check "$OUT" "Nivel 2" "L03 while"

# Lección 4

OUT="$(run lesson-04-methods-input $'Ana\n15\n')"
check "$OUT" "Hola, Ana" "L04 saludo"
check "$OUT" "Puedes participar" "L04 validacion de edad"

# Lección 5

OUT="$(run lesson-05-classes-objects)"
check "$OUT" "Ana obtuvo 16 puntos" "L05 objeto Ana"
check "$OUT" "Luis obtuvo 9 puntos" "L05 objeto Luis"
check "$OUT" "true" "L05 metodo aprobo"

# Lección 6

OUT="$(run lesson-06-encapsulation)"
check "$OUT" "Nueva nota: 18" "L06 setter"
check "$OUT" "Error: la nota debe estar entre 0 y 20" "L06 validacion"
check "$OUT" "Nota final: 18" "L06 integridad"

# Lección 7

OUT="$(run lesson-07-arrays-strings)"
check "$OUT" "ANA: 16" "L07 nombres"
check "$OUT" "Promedio del grupo: 15.333" "L07 promedio"

# Lección 8: flujo principal

OUT="$(run lesson-08-final-project $'1\nAna\n16\n1\nLuis\n12\n2\n3\nana\n4\n0\n')"

check "$OUT" "Estudiante registrado correctamente" "L08 registro"
check "$OUT" "Encontrado: Ana, nota 16" "L08 busqueda"
check "$OUT" "Promedio del grupo: 14.0" "L08 promedio"

# Lección 8: entradas incorrectas

OUT="$(run lesson-08-final-project $'abc\n4\n1\n\n1\nPedro\n25\n1\nAna\n11\n3\nSara\n0\n')"

check "$OUT" "Escribe un número entero válido" "L08 opcion incorrecta"
check "$OUT" "No hay notas para promediar" "L08 lista vacia"
check "$OUT" "El nombre no puede estar vacío" "L08 nombre vacio"
check "$OUT" "La nota debe estar entre 0 y 20" "L08 nota invalida"
check "$OUT" "No se encontró ese nombre" "L08 busqueda sin resultados"

# Lección 8: capacidad maxima

INPUT=""
for i in $(seq 1 11); do
  INPUT+="1\nAlumno$i\n15\n"
done
INPUT+="0\n"

OUT="$(run lesson-08-final-project "$(printf '%b' "$INPUT")")"

check "$OUT" "El registro está lleno" "L08 limite de 10 estudiantes"

echo
echo "========================================"
echo " RESULTADO: PRUEBAS SATISFACTORIAS"
echo " Archivos Java compilados: $TOTAL"
echo " Lecciones verificadas: 8"
echo "========================================"
