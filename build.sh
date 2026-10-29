
#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

echo "=== 1. Pobieranie miniaturek YouTube ==="
python3 download-thumbnails.py

echo "=== 2. Generowanie wersji ONLINE ==="
VIDEO_MODE=online quarto render --profile online

rm -rf _site-online
cp -a _site _site-online

echo "=== 3. Generowanie wersji OFFLINE ==="
VIDEO_MODE=offline quarto render --profile offline

rm -rf _site-offline
cp -a _site _site-offline

echo "=== 4. Sprawdzanie wyników ==="
test -f _site-online/wyklad01.html
test -f _site-offline/wyklad01.html
test -d _site-online/site_libs
test -d _site-offline/site_libs

echo "=== 5. Tworzenie archiwów ZIP ==="
rm -f prezentacje-online.zip prezentacje-offline.zip

(
  cd _site-online
  zip -qr ../prezentacje-online.zip .
)

(
  cd _site-offline
  zip -qr ../prezentacje-offline.zip .
)

echo ""
echo "GOTOWE!"
ls -lh prezentacje-online.zip prezentacje-offline.zip
