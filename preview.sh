
#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

quarto preview 01_warstwa_wierzchnia.qmd \
  --to revealjs \
  --metadata-file _metadata.yml \
  --no-browser
