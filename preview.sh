
#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

quarto preview 02_trawienie_elektrochemiczne.qmd \
  --to revealjs \
  --metadata-file _metadata.yml \
  --no-browser
