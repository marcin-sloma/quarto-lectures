
#!/bin/bash
cd "$(dirname "$0")"

quarto preview 01_warstwa_wierzchnia.qmd \
  --to revealjs \
  --no-browser \
  --host 0.0.0.0 \
  --port 8000
