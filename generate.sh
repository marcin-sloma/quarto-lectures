#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"
NAME=$(<_aktualne)

echo "=== 1. Przygotowanie miniaturek YouTube ==="
python3 download-thumbnails.py

echo "=== 2. Usuwanie zbędnych czcionek Source Sans Pro ==="

FILE="/opt/quarto/share/formats/revealjs/quarto.scss"

if grep -qF '@import url(./fonts/source-sans-pro/source-sans-pro.css);' "$FILE"; then
    sudo sed -i \
      '/@import url(\.\/fonts\/source-sans-pro\/source-sans-pro\.css);/d' \
      "$FILE"
    echo "Usunięto import Source Sans Pro."
else
    echo "Import Source Sans Pro już usunięty."
fi

echo "=== 3. Generowanie samodzielnego HTML ==="
quarto render "${NAME}.qmd" \
  --to revealjs \
  --metadata-file _metadata.yml \
  -M embed-resources:true

echo ""
echo "=== Gotowe ==="
ls -lh "${NAME}.html"