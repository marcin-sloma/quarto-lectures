
#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

echo "=== 1. Przygotowanie miniaturek YouTube ==="
python3 download-thumbnails.py

echo "=== 2. Generowanie samodzielnego HTML ==="
quarto render 01_warstwa_wierzchnia.qmd \
  --to revealjs \
  --metadata-file _metadata.yml \
  -M embed-resources:true

echo ""
echo "=== Gotowe ==="
ls -lh 01_warstwa_wierzchnia.html
