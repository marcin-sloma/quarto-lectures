
#!/bin/bash
set -e

cd "$(dirname "$0")"

echo "Generowanie prezentacji HTML..."

quarto render wyklad01.qmd \
  --to revealjs \
  --metadata-file _metadata.yml

echo ""
echo "Gotowe:"
ls -lh wyklad01.html
