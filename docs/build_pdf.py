#!/usr/bin/env python3
"""Generate timeline.pdf dari docs/timeline.md.

Menggunakan reportlab (PDF library Python murni, tanpa browser engine).
Dipanggil otomatis oleh workflow saat pandoc/wkhtmltopdf tidak tersedia.
"""
from __future__ import annotations

import re
from pathlib import Path

from reportlab.lib import colors
from reportlab.lib.pagesizes import A4
from reportlab.lib.styles import ParagraphStyle, getSampleStyleSheet
from reportlab.lib.units import cm
from reportlab.platypus import (
    BaseDocTemplate,
    Frame,
    KeepTogether,
    PageTemplate,
    Paragraph,
    Spacer,
    Table,
    TableStyle,
)

DOCS = Path(__file__).parent
MD = DOCS / "timeline.md"
OUT = DOCS / "timeline.pdf"

PAGE_W, PAGE_H = A4
MARGIN_X = 2.2 * cm
MARGIN_TOP = 2.4 * cm
MARGIN_BOTTOM = 2.0 * cm

PRIMARY = colors.HexColor("#2E7D32")   # Forest green
ACCENT = colors.HexColor("#4CAF50")
MUTED = colors.HexColor("#6B7280")
LIGHT_BG = colors.HexColor("#E8F5E9")
RULE = colors.HexColor("#D1D5DB")


def build_styles() -> dict[str, ParagraphStyle]:
    base = getSampleStyleSheet()
    styles = {
        "h1": ParagraphStyle(
            "h1", parent=base["Heading1"], fontName="Helvetica-Bold",
            fontSize=22, leading=28, spaceBefore=8, spaceAfter=10,
            textColor=PRIMARY,
        ),
        "h2": ParagraphStyle(
            "h2", parent=base["Heading2"], fontName="Helvetica-Bold",
            fontSize=15, leading=20, spaceBefore=16, spaceAfter=8,
            textColor=PRIMARY,
        ),
        "h3": ParagraphStyle(
            "h3", parent=base["Heading3"], fontName="Helvetica-Bold",
            fontSize=12, leading=16, spaceBefore=10, spaceAfter=4,
            textColor=ACCENT,
        ),
        "body": ParagraphStyle(
            "body", parent=base["BodyText"], fontName="Helvetica",
            fontSize=9.5, leading=14, spaceAfter=6, textColor=colors.HexColor("#1F2937"),
        ),
        "bullet": ParagraphStyle(
            "bullet", parent=base["BodyText"], fontName="Helvetica",
            fontSize=9.5, leading=14, leftIndent=14, bulletIndent=4,
            spaceAfter=3, textColor=colors.HexColor("#1F2937"),
        ),
        "quote": ParagraphStyle(
            "quote", parent=base["BodyText"], fontName="Helvetica-Oblique",
            fontSize=10, leading=14, leftIndent=14, textColor=MUTED,
            spaceAfter=6,
        ),
        "code": ParagraphStyle(
            "code", parent=base["Code"], fontName="Courier",
            fontSize=8.5, leading=12, leftIndent=10, backColor=LIGHT_BG,
            borderPadding=4, spaceAfter=4, textColor=colors.HexColor("#111827"),
        ),
        "small": ParagraphStyle(
            "small", parent=base["BodyText"], fontName="Helvetica",
            fontSize=8, leading=10, textColor=MUTED,
        ),
        "title_meta": ParagraphStyle(
            "title_meta", parent=base["BodyText"], fontName="Helvetica",
            fontSize=10, leading=14, textColor=MUTED, spaceAfter=4,
        ),
    }
    return styles


def _normalize_inline(text: str) -> str:
    """Replace unicode glyphs yang tidak ada di Helvetica dengan ASCII-safe.

    Helvetica (Type1) tidak punya glyph untuk: • ● ✅ ❌ ⚠️ → ▼ ★ ◆ ─ ─.
    Kita petakan ke karakter ASCII agar tidak muncul sebagai kotak kosong.
    """
    repl = {
        "✅": "[OK] ",
        "❌": "[  ] ",
        "⚠️": "[!] ",
        "✓": "v ",
        "•": "•",   # bullet: kita render manual via bulletText, bukan glyph
        "→": "->",
        "←": "<-",
        "–": "-",
        "—": "-",
        " ": " ",
        "…": "...",
        "“": '"',
        "”": '"',
        "‘": "'",
        "’": "'",
        "├": "+",
        "└": "+",
        "│": "|",
        "█": "=",
        "▌": "=",
    }
    for k, v in repl.items():
        text = text.replace(k, v)
    return text


def _inline_md(text: str, base_style: ParagraphStyle) -> str:
    """Escape and convert minimal inline markdown (**bold**, `code`)."""
    text = text.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;")
    # normalisasi glyph unicode ke ASCII-safe SEBELUM bold/code diproses
    text = _normalize_inline(text)
    # bold
    text = re.sub(r"\*\*(.+?)\*\*", r"<b>\1</b>", text)
    # italic
    text = re.sub(r"(?<!\*)\*([^*]+)\*(?!\*)", r"<i>\1</i>", text)
    # inline code
    text = re.sub(r"`([^`]+)`", r'<font face="Courier" color="#111827">\1</font>', text)
    # links [text](url) -> styled text
    text = re.sub(r"\[([^\]]+)\]\(([^)]+)\)", r'<font color="#2E7D32"><u>\1</u></font>', text)
    return text


def parse_md(md: str, styles: dict[str, ParagraphStyle]) -> list:
    flow: list = []
    # Normalisasi SEMUA baris di awal agar karakter unicode (emoji, arrow,
    # bullet, em-dash) di sumber Markdown ter-convert ke ASCII-safe SEBELUM
    # masuk ke laporan ReportLab (Helvetica tidak punya glyph-nya).
    lines = [_normalize_inline(l) for l in md.splitlines()]
    i = 0
    in_code = False
    code_buf: list[str] = []
    list_open = False

    def flush_list() -> None:
        nonlocal list_open
        list_open = False

    # `normalize` adalah alias dari `_normalize_inline`, dipertahankan untuk
    # backward-compat dengan helper di bawah.
    def normalize(s: str) -> str:
        return _normalize_inline(s)

    while i < len(lines):
        raw = lines[i]
        line = raw.rstrip()

        # fenced code
        if line.startswith("```"):
            if not in_code:
                in_code = True
                code_buf = []
            else:
                in_code = False
                flow.append(Paragraph(
                    "<br/>".join(_inline_md(c, styles["code"]) for c in code_buf) or "&nbsp;",
                    styles["code"],
                ))
            i += 1
            continue
        if in_code:
            code_buf.append(line)
            i += 1
            continue

        # blank
        if not line.strip():
            if list_open:
                flush_list()
            flow.append(Spacer(1, 4))
            i += 1
            continue

        # heading
        m = re.match(r"^(#{1,6})\s+(.*)$", line)
        if m:
            if list_open:
                flush_list()
            level = len(m.group(1))
            text = m.group(2).strip()
            style_key = {1: "h1", 2: "h2", 3: "h3"}.get(level, "h3")
            flow.append(Paragraph(_inline_md(text, styles[style_key]), styles[style_key]))
            i += 1
            continue

        # blockquote
        if line.startswith(">"):
            if list_open:
                flush_list()
            text = line.lstrip(">").strip()
            flow.append(Paragraph(_inline_md(text, styles["quote"]), styles["quote"]))
            i += 1
            continue

        # horizontal rule
        if re.match(r"^---+$", line.strip()):
            if list_open:
                flush_list()
            flow.append(Spacer(1, 4))
            i += 1
            continue

        # bullet list
        m = re.match(r"^[\-\*]\s+(.*)$", line)
        if m:
            text = m.group(1).strip()
            flow.append(Paragraph(
                _inline_md(text, styles["bullet"]),
                styles["bullet"],
                bulletText="•",
            ))
            list_open = True
            i += 1
            continue

        # numbered list -> treat as bullet with number
        m = re.match(r"^\d+\.\s+(.*)$", line)
        if m:
            text = m.group(1).strip()
            flow.append(Paragraph(
                _inline_md(text, styles["bullet"]),
                styles["bullet"],
                bulletText="•",
            ))
            list_open = True
            i += 1
            continue

        # table: detect block of pipe lines
        if line.startswith("|"):
            table_lines = []
            while i < len(lines) and lines[i].startswith("|"):
                table_lines.append(lines[i])
                i += 1
            tbl = build_table(table_lines, styles)
            if tbl is not None:
                flow.append(tbl)
                flow.append(Spacer(1, 6))
            continue

        # paragraph: gather consecutive non-blank, non-special lines
        para = [line]
        i += 1
        while i < len(lines):
            nxt = lines[i].rstrip()
            if (not nxt.strip()
                or nxt.startswith("#")
                or nxt.startswith(">")
                or nxt.startswith("-")
                or nxt.startswith("*")
                or re.match(r"^\d+\.\s", nxt)
                or nxt.startswith("|")
                or nxt.startswith("```")
                or re.match(r"^---+$", nxt.strip())):
                break
            para.append(nxt)
            i += 1
        text = " ".join(p.strip() for p in para)
        flow.append(Paragraph(_inline_md(text, styles["body"]), styles["body"]))

    return flow


def split_row(line: str) -> list[str]:
    line = line.strip()
    if line.startswith("|"):
        line = line[1:]
    if line.endswith("|"):
        line = line[:-1]
    return [c.strip() for c in line.split("|")]


def build_table(lines: list[str], styles: dict[str, ParagraphStyle]):
    if len(lines) < 2:
        return None
    header = split_row(lines[0])
    # skip separator line (contains ---)
    body_lines = [l for l in lines[1:] if not re.match(r"^\|?\s*:?-+:?\s*(\|\s*:?-+:?\s*)+\|?\s*$", l)]
    rows = [split_row(l) for l in body_lines]
    data = [header] + rows
    data = [[Paragraph(_inline_md(c, styles["small"]), styles["small"]) for c in r] for r in data]

    col_count = max(len(r) for r in data)
    # equal-width columns inside page width
    avail = PAGE_W - 2 * MARGIN_X
    col_w = [avail / col_count] * col_count

    tbl = Table(data, colWidths=col_w, repeatRows=1)
    tbl.setStyle(TableStyle([
        ("BACKGROUND", (0, 0), (-1, 0), PRIMARY),
        ("TEXTCOLOR", (0, 0), (-1, 0), colors.white),
        ("FONTNAME", (0, 0), (-1, 0), "Helvetica-Bold"),
        ("FONTSIZE", (0, 0), (-1, -1), 8),
        ("VALIGN", (0, 0), (-1, -1), "TOP"),
        ("LEFTPADDING", (0, 0), (-1, -1), 4),
        ("RIGHTPADDING", (0, 0), (-1, -1), 4),
        ("TOPPADDING", (0, 0), (-1, -1), 4),
        ("BOTTOMPADDING", (0, 0), (-1, -1), 4),
        ("ROWBACKGROUNDS", (0, 1), (-1, -1), [colors.white, LIGHT_BG]),
        ("LINEBELOW", (0, 0), (-1, -1), 0.25, RULE),
        ("LINEAFTER", (0, 0), (-1, -2), 0.25, RULE),
        ("BOX", (0, 0), (-1, -1), 0.5, PRIMARY),
    ]))
    return tbl


def add_page_decorations(canvas, doc):
    canvas.saveState()
    # header bar
    canvas.setFillColor(PRIMARY)
    canvas.rect(0, PAGE_H - 1.2 * cm, PAGE_W, 1.2 * cm, stroke=0, fill=1)
    canvas.setFillColor(colors.white)
    canvas.setFont("Helvetica-Bold", 9)
    canvas.drawString(MARGIN_X, PAGE_H - 0.8 * cm, "GO GURU")
    canvas.setFont("Helvetica", 9)
    canvas.drawRightString(PAGE_W - MARGIN_X, PAGE_H - 0.8 * cm,
                           "Roadmap & Timeline")
    # footer
    canvas.setStrokeColor(RULE)
    canvas.setLineWidth(0.3)
    canvas.line(MARGIN_X, 1.2 * cm, PAGE_W - MARGIN_X, 1.2 * cm)
    canvas.setFillColor(MUTED)
    canvas.setFont("Helvetica", 8)
    canvas.drawString(MARGIN_X, 0.7 * cm,
                      "GO GURU — Mobile-only MVP (Android & iOS) • 1 Bulan Non-Stop")
    canvas.drawRightString(PAGE_W - MARGIN_X, 0.7 * cm, f"Halaman {doc.page}")
    canvas.restoreState()


def main() -> None:
    md = MD.read_text(encoding="utf-8")
    # Strip YAML frontmatter (pandoc-specific, tidak dipakai oleh reportlab)
    md = re.sub(r"^---\n.*?\n---\n", "", md, count=1, flags=re.DOTALL)

    styles = build_styles()
    flow = parse_md(md, styles)

    doc = BaseDocTemplate(
        str(OUT),
        pagesize=A4,
        leftMargin=MARGIN_X, rightMargin=MARGIN_X,
        topMargin=MARGIN_TOP, bottomMargin=MARGIN_BOTTOM,
        title="Roadmap & Timeline GO GURU",
        author="Tim Produk GO GURU",
        subject="Timeline pengembangan 1 bulan non-stop",
    )
    frame = Frame(MARGIN_X, MARGIN_BOTTOM, PAGE_W - 2 * MARGIN_X,
                  PAGE_H - MARGIN_TOP - MARGIN_BOTTOM, id="main",
                  leftPadding=0, rightPadding=0, topPadding=0, bottomPadding=0)
    doc.addPageTemplates(PageTemplate(id="all", frames=[frame],
                                      onPage=add_page_decorations))
    doc.build(flow)
    print(f"Wrote {OUT} ({OUT.stat().st_size / 1024:.1f} KB)")


if __name__ == "__main__":
    main()