#!/bin/bash
set -e

FILE="/opt/quarto/share/formats/revealjs/quarto.scss"

sudo sed -i \
'/@import url(\.\/fonts\/source-sans-pro\/source-sans-pro\.css);/d' \
"$FILE"