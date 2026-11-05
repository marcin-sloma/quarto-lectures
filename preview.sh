
#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

quarto preview test_size.qmd \
  --to revealjs \
  --metadata-file _metadata.yml \
  --no-browser
