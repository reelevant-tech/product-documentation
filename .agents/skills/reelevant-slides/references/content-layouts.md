# Content Layout Inspiration

Source: "Exemple de design de slides - 2026"
https://docs.google.com/presentation/d/1FMF01l-BPoVFaYVw8AoY8jSWYWbixQvjQ4e3bPrZ6vM/

These are proven layout patterns used on real Reelevant decks. Use them to populate S16/S17 content areas. All coordinates assume the 20" × 11.25" slide size. Content area starts at ~1.6" from top (below the title placeholder).

---

## Layout 1 — 3-Column Feature Grid
*Reference: slide 6 "UNE INFINITÉ DE CAS D'USAGES"*

3 equal columns, each with a header label and bullet list below.
Use on S16 (white) or S17 (yellow footer).

```
| COLUMN A      | COLUMN B      | COLUMN C      |
|---------------|---------------|---------------|
| Header label  | Header label  | Header label  |
| • item        | • item        | • item        |
| • item        | • item        | • item        |
```

**Implementation (S16/S17 content area):**
- Column width: ~5.5", gap: ~0.3"
- Start left: 1.23", top: 1.8"
- Header: Anton, 20–24pt, uppercase, colored fill (yellow, black, or blue — pick one per column, follow 2-color rule)
- Body bullets: Inter, 14–16pt, #0C0C0C or #FFFFFF depending on bg

```python
# 3 columns on a white S16 slide
cols = [
    ('CANAUX', ['Déploiement multicanal', 'Cohérence marketing', 'Push, RCS, Whatsapp']),
    ('FORMAT', ['Live polling', 'Géolocalisation', 'Digest personnalisé']),
    ('DATAS', ['Données dormantes', 'Météo', 'Stocks, Avis']),
]
col_colors = ['0C0C0C', 'EEFF00', '0C0C0C']  # max 2 dominant colors
text_colors = ['FFFFFF', '0C0C0C', 'FFFFFF']

for i, (header, items) in enumerate(cols):
    left = 1.23 + i * 6.1
    # Header rect
    add_rect(slide, left, 1.8, 5.5, 0.7, fill=col_colors[i])
    add_textbox(slide, left + 0.1, 1.85, 5.3, 0.6, header,
                font='Anton', size=22, color=text_colors[i])
    # Bullet items
    for j, item in enumerate(items):
        add_textbox(slide, left + 0.2, 2.65 + j * 0.55, 5.1, 0.5, f'• {item}',
                    font='Inter', size=14, color='0C0C0C')
```

---

## Layout 2 — 2-Column Comparison
*Reference: slide 7 "REELEVANT x NATURE ET DÉCOUVERTES"*

Two blocks side by side — current state vs future state, or option A vs option B.
Use on S16 or S17.

```
| LEFT BLOCK            | RIGHT BLOCK           |
| (e.g. current state)  | (e.g. 2026 state)     |
| label: value          | label: value          |
| label: value          | label: value          |
```

**Implementation:**
- Each block: width ~8", left block at 1.23", right block at 10.0"
- Block header: Anton 20pt, uppercase, background fill
- Left block: neutral color (#F6F6F6 or #D9D9D9 fill)
- Right block: yellow (#EEFF00) or black (#0C0C0C) fill to highlight the preferred option
- Content rows: Inter 14–16pt

```python
# Left block (current / neutral)
add_rect(slide, 1.23, 1.8, 8.0, 5.5, fill='F6F6F6', line='D9D9D9')
add_textbox(slide, 1.33, 1.9, 7.8, 0.6, 'PÉRIMÈTRE ACTUEL',
            font='Anton', size=20, color='0C0C0C')

# Right block (highlight)
add_rect(slide, 10.0, 1.8, 8.0, 5.5, fill='EEFF00')
add_textbox(slide, 10.1, 1.9, 7.8, 0.6, 'PÉRIMÈTRE 2026',
            font='Anton', size=20, color='0C0C0C')

# Content rows in each block
rows = [('Volume IU', '500 000'), ('Solution', '37 000€ HT/an'), ('Engagement', '2 ans')]
for j, (label, value) in enumerate(rows):
    y = 2.7 + j * 0.9
    add_textbox(slide, 1.33, y, 3.5, 0.5, label, font='Inter', size=13, color='888888')
    add_textbox(slide, 1.33, y + 0.3, 7.5, 0.5, value, font='Inter', size=16, bold=True, color='0C0C0C')
```

---

## Layout 3 — Data Table
*Reference: slides 8, 11, 15 (ENGIE, SANDRO & MAJE, CABAIA)*

Full-width table with black header row and yellow highlight for totals.
Use on S16 (white) — tables are hard to read on yellow footer.

```python
from pptx.util import Inches, Pt
from pptx.dml.color import RGBColor

def add_table(slide, headers, rows, left=1.23, top=1.8, width=17.5, highlight_last=True):
    """
    headers: list of strings (use '' for an empty corner/label cell)
    rows: list of lists of strings
    highlight_last: if True, last row gets yellow fill (total row)
    """
    col_count = len(headers)
    row_count = len(rows) + 1  # +1 for header
    row_height = 0.65

    table = slide.shapes.add_table(
        row_count, col_count,
        Inches(left), Inches(top),
        Inches(width), Inches(row_height * row_count)
    ).table

    def set_cell(cell, text, size, bold, text_rgb, fill_rgb):
        # IMPORTANT: cell.text on an empty string does not create a run.
        # Always grab-or-create the run, then assign text to it, so styling
        # never throws IndexError on empty cells (e.g. the corner label).
        cell.fill.solid()
        cell.fill.fore_color.rgb = fill_rgb
        para = cell.text_frame.paragraphs[0]
        run = para.runs[0] if para.runs else para.add_run()
        run.text = text
        run.font.name = 'Inter'
        run.font.size = Pt(size)
        run.font.bold = bold
        run.font.color.rgb = text_rgb

    # Header row
    for j, header in enumerate(headers):
        set_cell(table.cell(0, j), header.upper(), 12, True,
                 RGBColor(0xFF, 0xFF, 0xFF), RGBColor(0x0C, 0x0C, 0x0C))

    # Data rows
    for i, row in enumerate(rows):
        is_last = (i == len(rows) - 1)
        fill_color = RGBColor(0xEE, 0xFF, 0x00) if (highlight_last and is_last) else (
                     RGBColor(0xF6, 0xF6, 0xF6) if i % 2 == 0 else RGBColor(0xFF, 0xFF, 0xFF))
        for j, val in enumerate(row):
            bold = bool(highlight_last and is_last) or (j == 0)
            set_cell(table.cell(i + 1, j), val, 13, bold,
                     RGBColor(0x0C, 0x0C, 0x0C), fill_color)

    return table
```

---

## Layout 4 — Stat Callout
*Reference: slide 13 "The Benefits / ROI X4"*

One or two large stats with labels. Works as a punchline-style layout on S16/S17 or combined with the Punchline slides (S11/S12).

```python
# Big stat, center of content area
add_textbox(slide, 1.23, 2.5, 10, 3.5, 'ROI X4',
            font='Anton', size=120, color='0C0C0C')
add_textbox(slide, 1.23, 6.2, 10, 1.0,
            'For both Sandro and Maje, based on incremental revenue over 10 months.',
            font='Inter', size=16, color='888888')
```

For multiple stats side by side:
```python
stats = [('X3.92', 'taux d\'interaction'), ('X5.26', 'taux de conversion')]
for i, (num, label) in enumerate(stats):
    left = 1.23 + i * 9
    add_textbox(slide, left, 2.5, 8, 3, num, font='Anton', size=96, color='0C0C0C')
    add_textbox(slide, left, 5.5, 8, 0.8, f'% de {label}',
                font='Inter', size=16, color='888888')
```

---

## Layout 5 — Team Grid
*Reference: slide 5 "YOUR REELEVANT TEAM"*

Photos + name + role cards in a row. Photos go in image placeholders or as image shapes.
Use on S16 (dark variant via add_rect black background) or a dark S19 layout.

Structure:
- Dark background: add_rect covering full slide or content area
- Per person card: photo area (image shape), name (Anton 18pt yellow), role (Inter 12pt gray), tag line (Inter 11pt yellow)

```python
# Dark background over content area
add_rect(slide, 0, 0, 20, 11.25, fill='0C0C0C')

# Per person (4 columns)
people = [('Margaux', 'Customer Success Manager', 'MAIN DAY-TO-DAY CONTACT')]
for i, (name, role, tag) in enumerate(people):
    left = 1.5 + i * 4.5
    # Photo placeholder (add_rect as stand-in if no image)
    add_rect(slide, left, 1.8, 3.5, 4.0, fill='2F2F2F')
    add_textbox(slide, left, 5.95, 3.5, 0.5, name.upper(),
                font='Anton', size=18, color='FFFFFF')
    add_textbox(slide, left, 6.5, 3.5, 0.5, role,
                font='Inter', size=12, color='888888')
    # Tag badge
    add_rect(slide, left, 7.1, 3.5, 0.4, fill='EEFF00')
    add_textbox(slide, left + 0.05, 7.12, 3.4, 0.35, tag,
                font='Inter', size=10, bold=True, color='0C0C0C')
```

---

## Layout 6 — Mixed Content (Text + Visual)
*Reference: slide 16 "EST CONSIDÉRÉ COMME HYPER-PERSONNALISÉ", slide 17 "EMAIL 100% HYPER-PERSONNALISÉ"*

Left column: text/explanation. Right column: visual (diagram, screenshot, image).

```python
# Left text column
add_textbox(slide, 1.23, 1.8, 8.5, 7.5, body_text,
            font='Inter', size=15, color='0C0C0C')

# Right visual area — use rect as placeholder or insert image
add_rect(slide, 10.5, 1.8, 8.0, 7.5, fill='F6F6F6', line='D9D9D9')
# Insert image if available:
# slide.shapes.add_picture(img_path, Inches(10.5), Inches(1.8), Inches(8.0), Inches(7.5))
```

---

## Layout 7 — Objective/KPI Cards
*Reference: slide 14 "YOUR OBJECTIVES & KPIS"*

Horizontal row of pill-shaped or rounded cards, each with a label.

```python
kpis = ['Customer retention & loyalty growth', 'VIP & high-value customer development',
        'Incremental sales driven by CRM', 'Scalable personalization strategy']

for i, kpi in enumerate(kpis):
    left = 1.23 + i * 4.55
    # Card background — alternate black and yellow
    fill = 'EEFF00' if i % 2 == 0 else '0C0C0C'
    text_color = '0C0C0C' if fill == 'EEFF00' else 'FFFFFF'
    add_rect(slide, left, 3.5, 4.2, 3.0, fill=fill)
    add_textbox(slide, left + 0.15, 3.7, 3.9, 2.6, kpi,
                font='Inter', size=15, bold=True, color=text_color)
```

---

## Layout 8 — 3D Polygonal Shapes (for explaining concepts)

When a concept benefits from a visual model — a hierarchy, a funnel, a progression, a stack — add a **3D polygonal shape** rather than plain text. The Reelevant style here is **low-poly / flat-shaded 3D**: the form is broken into flat polygonal facets, each a single flat-color fill (no gradients), in a consistent isometric angle, with lighter fills on faces toward the light (front/top) and darker fills on faces in shadow (side/receding). The pyramid on S16 of the design examples deck is the reference.

### Base helper — arbitrary filled polygon

```python
from pptx.util import Pt, Inches
from pptx.dml.color import RGBColor

def add_freeform_poly(slide, pts_in, fill_hex, line_hex=None):
    """pts_in: list of (x, y) vertices in inches. Builds one filled polygon face."""
    pts = [(Inches(x), Inches(y)) for x, y in pts_in]
    fb = slide.shapes.build_freeform(pts[0][0], pts[0][1], scale=1)
    fb.add_line_segments(pts[1:], close=True)
    shape = fb.convert_to_shape()
    shape.fill.solid()
    shape.fill.fore_color.rgb = RGBColor.from_string(fill_hex)
    if line_hex:
        shape.line.color.rgb = RGBColor.from_string(line_hex)
        shape.line.width = Pt(0.75)
    else:
        shape.line.fill.background()
    shape.shadow.inherit = False
    return shape
```

### 3D layered pyramid (hierarchy / maturity model) — RECOMMENDED: clone the real one

The cleanest result comes from cloning the **actual 3-tier 3D pyramid** from the design examples deck (S16), which has true perspective side faces. Its exact geometry is bundled in the skill at `assets/shapes/pyramid_3d.xml`. Clone it rather than recomputing perspective by hand — a hand-built version comes out flat.

```python
import copy
from lxml import etree
from pptx.util import Inches

def add_pyramid_3d(slide, left_in, top_in, width_in=7.5, skill_dir='.'):
    """Clone the exact 3-tier 3D pyramid (dark apex -> light base) onto the slide.
    Position by top-left corner; width_in scales the whole group proportionally."""
    with open(f'{skill_dir}/assets/shapes/pyramid_3d.xml') as f:
        el = etree.fromstring(f.read())
    A = 'http://schemas.openxmlformats.org/drawingml/2006/main'
    P = 'http://schemas.openxmlformats.org/presentationml/2006/main'
    xfrm = el.find(f'.//{{{P}}}grpSpPr/{{{A}}}xfrm')
    off = xfrm.find(f'{{{A}}}off')
    ext = xfrm.find(f'{{{A}}}ext')
    cur_cx = int(ext.get('cx'))
    scale = Inches(width_in) / cur_cx
    off.set('x', str(Inches(left_in)))
    off.set('y', str(Inches(top_in)))
    ext.set('cx', str(int(cur_cx * scale)))
    ext.set('cy', str(int(int(ext.get('cy')) * scale)))
    slide.shapes._spTree.append(copy.deepcopy(el))
    return el
```

The bundled pyramid has **3 tiers** (apex `#0C0C0C` → mid greys → base `#D9D9D9`) with real 3D side faces. Pair it with right-aligned text labels (Anton header + Inter description per tier). Keep the pyramid on the left (left ≈ 2", width ≈ 7.5") and labels on the right (left ≈ 11.5"), top tier label highest.

To recolor a tier (e.g. make the apex yellow `#EEFF00` to highlight the target level), find the relevant freeform `<p:sp>` inside the cloned group and set its `<a:solidFill>`. Only recolor one tier — keep the rest greyscale (two-color rule).

### 3D funnel (conversion / qualification / filtering)

A low-poly funnel is an **inverted pyramid** — wide opening at top, narrowing to a point at the bottom — in the same faceted iso style as the pyramid. Like the pyramid, each tier shows **two front faces** (left lighter, right darker) meeting on a central vertical edge that points toward the viewer; this is what makes it read as 3D rather than flat. A two-facet rim forms the opening at the top.

```python
def add_funnel_3d(slide, cx, top_y, levels=3, width=6.5, height=5.0, depth=0.7):
    """Low-poly inverted-pyramid funnel with two front faces per tier (like the pyramid).
    cx=horizontal center, top_y=y of the opening, depth=how far the central edge juts forward."""
    left  = ['E2E2E2', '9A9A9A', '4A4A4A', '141414', '000000']  # left faces, light->dark
    right = ['C2C2C2', '7A7A7A', '333333', '0A0A0A', '000000']  # right faces, a notch darker
    top_hw, bot_hw = width/2, width/9
    def hw(frac): return top_hw + (bot_hw - top_hw) * frac
    tier_h = height / levels

    # top rim (opening): two facets meeting at the central front point
    fhw = hw(0)
    add_freeform_poly(slide, [(cx-fhw, top_y), (cx, top_y), (cx, top_y+depth)], 'EFEFEF')
    add_freeform_poly(slide, [(cx, top_y), (cx+fhw, top_y), (cx, top_y+depth)], 'DADADA')

    for i in range(levels):
        f_t, f_b = i/levels, (i+1)/levels
        hw_t, hw_b = hw(f_t), hw(f_b)
        yt_back, yb_back = top_y + i*tier_h, top_y + (i+1)*tier_h
        yt_front, yb_front = yt_back + depth, yb_back + depth
        # left front face
        add_freeform_poly(slide, [(cx-hw_t, yt_back), (cx, yt_front),
                                  (cx, yb_front), (cx-hw_b, yb_back)], left[min(i,len(left)-1)])
        # right front face
        add_freeform_poly(slide, [(cx, yt_front), (cx+hw_t, yt_back),
                                  (cx+hw_b, yb_back), (cx, yb_front)], right[min(i,len(right)-1)])
```

Pair with right-aligned labels per tier (Anton header + Inter description), like the pyramid. Keep it on the left (cx ≈ 5.2"), labels on the right.

### Building other 3D shapes from scratch

For shapes not bundled as assets, compose them from freeform faces with `add_freeform_poly`. **The low-poly / flat-shading recipe** (the name of this style): decompose the form into flat polygonal faces; give each face a single flat fill; lighter fills on faces toward the light (top/front), darker fills on faces in shadow (side/under); keep one consistent iso angle across all faces. A flat front-only shape (no side faces) reads as 2D and is NOT the Reelevant 3D style.

### When to use 3D shapes
- Hierarchy / maturity levels → pyramid (bundled asset, clone it)
- Conversion / qualification / filtering → funnel (`add_funnel_3d` above)
- A custom concept → compose `add_freeform_poly` faces yourself (front lighter, side darker, consistent iso angle)

### Color rule for 3D shapes
The greyscale ramp (D9D9D9 → 0C0C0C) counts as neutral, so it pairs cleanly with a yellow OR blue accent without breaking the two-color rule. You may make ONE tier the yellow `EEFF00` (e.g. the apex or the target tier) to draw the eye — but only one, and don't also add blue on the same slide.

---

## General Rules for Content Area

- **Top of content area:** 1.6" (just below title placeholder)
- **Bottom margin:** keep content above ~9.2" — the slanted black footer occupies the bottom of S16/S17. Never overlap it.
- **Left/right margins:** 1.23" each side (usable width: 17.54")
- **Don't crowd:** max 6–7 rows of text, or 3 columns, or 1 table per slide
- **Font hierarchy:** Anton for labels/headers (always uppercase), Inter for body, Instrument Serif for callout quotes
- **Never use all 3 dominant colors on one slide** — see color rule in SKILL.md
- **Use 3D polygonal shapes (Layout 8) to explain concepts** — hierarchies, funnels, progressions — instead of relying on text alone.
