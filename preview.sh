
#!/bin/bash
cd "$(dirname "$0")"

quarto preview wyklad01.qmd \
  --to revealjs \
  --no-browser \
  --host 0.0.0.0 \
  --port 8000
