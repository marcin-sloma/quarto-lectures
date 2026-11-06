
#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"
NAME=$(<aktualne)

quarto preview "${NAME}.qmd" \
  --to revealjs \
  --metadata-file _metadata.yml \
  --no-browser
