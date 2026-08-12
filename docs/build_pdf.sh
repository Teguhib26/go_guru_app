#!/usr/bin/env bash
# Generate docs/timeline.pdf menggunakan tool terbaik yang tersedia.
# Prioritas: pandoc + wkhtmltopdf -> reportlab (Python) -> exit 1.

set -euo pipefail

cd "$(dirname "$0")/.."
mkdir -p docs

OUT=docs/timeline.pdf
SRC=docs/timeline.md

if command -v pandoc >/dev/null 2>&1 && command -v wkhtmltopdf >/dev/null 2>&1; then
  echo "Rendering via pandoc + wkhtmltopdf..."
  TMP=$(mktemp -t goguru).html
  pandoc "$SRC" -s --metadata title="Roadmap & Timeline GO GURU" \
    --css=docs/style.css -o "$TMP"
  wkhtmltopdf --enable-local-file-access --quiet "$TMP" "$OUT"
  rm -f "$TMP"
  echo "OK -> $OUT ($(du -h "$OUT" | cut -f1))"
  exit 0
fi

if command -v python3 >/dev/null 2>&1 && python3 -c "import reportlab" >/dev/null 2>&1; then
  echo "Rendering via reportlab (fallback)..."
  python3 docs/build_pdf.py
  exit 0
fi

echo "ERROR: tidak ada generator PDF yang tersedia."
echo "Install salah satu: brew install pandoc wkhtmltopdf"
echo "Atau: pip3 install reportlab"
exit 1