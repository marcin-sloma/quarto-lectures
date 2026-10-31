
#!/bin/bash
set -euo pipefail

cd "$(dirname "$0")"

echo "=== 1. Zapis zmian w Git ==="

git add -A

if ! git diff --cached --quiet; then
    git commit -m "Backup $(date '+%Y-%m-%d %H:%M')"
else
    echo "Brak nowych zmian do zapisania."
fi

echo "=== 2. Wysyłanie na GitHub ==="

git push

echo "=== 3. Tworzenie archiwum ZIP ==="

mkdir -p backups

ZIP="backups/quarto-lectures-$(date '+%Y-%m-%d_%H-%M-%S').zip"

git archive --format=zip --output="$ZIP" HEAD

echo ""
echo "=== GOTOWE ==="
echo "GitHub: synchronizacja zakończona."
echo "Archiwum: $ZIP"

ls -lh "$ZIP"
