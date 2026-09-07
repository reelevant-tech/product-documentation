# Slide Library — Preferred Layouts by Number of Ideas

A library of **approved, good-looking layouts** organized by how many ideas/blocks the slide conveys. When a content slide carries N distinct ideas, **try the matching library layout first** — it is the preferred first choice.

> **Status:** six approved designs are defined below (S1–S4, S7, S8, S9). For idea counts without an approved design, fall back to the generic patterns in `content-layouts.md`.

> **Paths:** helpers below that load assets take a `skill_dir` argument. Always pass the absolute `SKILL_DIR` defined in `SKILL.md` (the absolute path of this skill directory inside the repo checkout), never the `'.'` default shown in the signatures. Relative paths do not resolve, since your code does not run from inside the skill directory.

**Two principles:**

1. **Fidelity over the S16/S17 conventions.** Library layouts should reproduce specific approved slides faithfully. Do NOT build them on the S16/S17 content layouts — those carry a slanted black footer the originals don't have. Build on the **clean full-bleed backgrounds** below and add the title yourself.
2. **Vary — don't apply systematically.** Don't repeat the same library layout on consecutive same-idea-count slides.

## Clean backgrounds (no footer)

| Background | Layout name | Note |
|------------|-------------|------|
| Plain yellow (full bleed) | `CUSTOM_5_1_1_1_1_1_1_1_2` | Clean, no footer. |
| Plain light/grey | `CUSTOM_5_1` | **Has a white strip above the title** — always lay a full-bleed `#F6F6F6` rect over the whole slide first (see `full_bg`), then build on top. |

No title placeholder on these — add the title as a text box: Anton 44pt uppercase, left=1.23" top=0.5".

## Shared helpers

Define these once, together with `add_textbox`/`add_textbox_into` from SKILL.md, before any layout below; `add_textbox` accepts a list of `(txt, font, size, bold, color, italic[, struck])` tuples and an `align=` kwarg.

```python
from pptx.enum.shapes import MSO_SHAPE
from pptx.util import Pt, Inches
from pptx.dml.color import RGBColor
from pptx.enum.text import PP_ALIGN, MSO_ANCHOR
from lxml import etree

SHADOW_XML = ('<a:effectLst xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main">'
              '<a:outerShdw blurRad="142875" rotWithShape="0" algn="bl" dir="2700000" dist="95250">'
              '<a:srgbClr val="000000"><a:alpha val="10000"/></a:srgbClr></a:outerShdw></a:effectLst>')

def strip_placeholders(slide):
    """Remove inherited title/subtitle placeholders so their prompt text doesn't show through."""
    for ph in list(slide.placeholders):
        ph._element.getparent().remove(ph._element)

def title_box(slide, text, color='0C0C0C'):
    tb = slide.shapes.add_textbox(Inches(1.23), Inches(0.5), Inches(17.5), Inches(1.3))
    p = tb.text_frame.paragraphs[0]; r = p.add_run(); r.text = text.upper()
    r.font.name = 'Anton'; r.font.size = Pt(44); r.font.bold = False
    r.font.color.rgb = RGBColor.from_string(color)

def full_bg(slide, color):
    """Full-bleed background rect, sent to back. Use on CUSTOM_5_1 to kill the white top strip."""
    sh = slide.shapes.add_shape(MSO_SHAPE.RECTANGLE, Inches(0), Inches(0), Inches(20), Inches(11.25))
    sh.fill.solid(); sh.fill.fore_color.rgb = RGBColor.from_string(color)
    sh.line.fill.background(); sh.shadow.inherit = False
    sp = sh._element; sp.getparent().remove(sp); slide.shapes._spTree.insert(2, sp)
    return sh

def round_card(slide, l, t, w, h, fill='FFFFFF', line=None, adj=0.10991):
    sh = slide.shapes.add_shape(MSO_SHAPE.ROUNDED_RECTANGLE, Inches(l), Inches(t), Inches(w), Inches(h))
    sh.fill.solid(); sh.fill.fore_color.rgb = RGBColor.from_string(fill)
    if line: sh.line.color.rgb = RGBColor.from_string(line); sh.line.width = Pt(1.2)
    else: sh.line.fill.background()
    sh.shadow.inherit = False
    try: sh.adjustments[0] = adj
    except: pass
    sh._element.spPr.append(etree.fromstring(SHADOW_XML))
    return sh

def hline(slide, l, t, w, color='0C0C0C', weight=1.5):
    ln = slide.shapes.add_connector(2, Inches(l), Inches(t), Inches(l+w), Inches(t))
    ln.line.color.rgb = RGBColor.from_string(color); ln.line.width = Pt(weight)
    return ln
```

---

## 1 idea
*(no approved library design yet)* — fall back to a **Stat Callout**, a **3D shape**, or a **Punchline** slide.

## 2 ideas — PREFERRED A: comparison cards (S2 style)
*Reproduced pixel-for-pixel from the priority deck (S2 "Reelevant x Nature et Découvertes").*

Light grey background (use `full_bg(slide,'F6F6F6')` over the `CUSTOM_5_1` layout). Two rounded cards with soft shadow: left **white** (current/neutral), right **yellow `#EEFF00`** (target/highlight). Each card: centered **Anton 72pt** title, black separator line, then label/value pairs (label Inter 24 bold, value Inter 24 regular). Values support **strikethrough** (e.g. an old price crossed out above the new one). An intro line under the title supports inline bold spans.

Key exact values: cards left `1.23 / 10.46`, top `3.75`, size `8.26 × 6.31`, roundRect `adj=0.07889`; separator line top `5.49`, width `7.24`; title placeholder Anton 60pt; intro at `1.28, 1.60`.

```python
def add_two_idea_comparison(prs, title, intro_lines, left, right):
    """S2 template. intro_lines = [[(text,bold),...], ...] (paragraphs w/ inline bold).
    left/right = (card_title, fill_hex, rows); rows = [(label, [(value_text, struck_bool),...]), ...]."""
    slide = prs.slides.add_slide(get_layout(prs, 'CUSTOM_5_1'))
    strip_placeholders(slide)
    full_bg(slide, 'F6F6F6')
    add_textbox(slide, 1.23, 0.43, 17.6, 1.1, [(title.upper(),'Anton',60,False,'0C0C0C',False)])
    # intro with inline bold
    tb = slide.shapes.add_textbox(Inches(1.28), Inches(1.60), Inches(16), Inches(1.0))
    tf = tb.text_frame; tf.word_wrap = True
    for i, para in enumerate(intro_lines):
        p = tf.paragraphs[0] if i == 0 else tf.add_paragraph()
        for (txt, b) in para:
            r = p.add_run(); r.text = txt
            r.font.name='Inter'; r.font.size=Pt(24); r.font.bold=b; r.font.color.rgb=RGBColor.from_string('0C0C0C')
    T, W, H, line_T = 3.75, 8.26, 6.31, 5.49
    for L, (ctitle, fill, rows) in zip([1.23, 10.46], [left, right]):
        round_card(slide, L, T, W, H, fill, adj=0.07889)
        add_textbox(slide, L+0.3, T+0.25, W-0.6, 1.5, [(ctitle.upper(),'Anton',72,False,'0C0C0C',False)], align=PP_ALIGN.CENTER)
        hline(slide, L+0.51, line_T, 7.24)
        y = line_T + 0.45
        for (label, vlines) in rows:
            add_textbox(slide, L+0.51, y, W-1.0, 0.5, [(label,'Inter',24,True,'0C0C0C',False)]); y += 0.52
            for (vt, struck) in vlines:
                # struck: pass a 7th tuple element to add_textbox lines -> sets a:strike="sngStrike"
                add_textbox(slide, L+0.51, y, W-1.0, 0.5, [(vt,'Inter',24,False,'0C0C0C',False,struck)]); y += 0.48
            y += 0.12
    return slide
```


## 2 ideas — PREFERRED B: contrast cards (S3 style)
*Reproduced pixel-for-pixel from the priority deck (S3 "Next Steps").*

Yellow background, two tall rounded cards with shadow (`adj=0.07889`): left **white**, right **black `#0C0C0C`**. Centered **Anton 72pt** title (black on white card, white on black card), separator line. Left card = an **icon-bulleted list** (Reelevant `icon-black.png`) with a thin underline beneath each item. Right card = a `Matchings :` bold line + regular lines, all white.

Key values: cards left `1.25 / 10.49`, top `2.56`, size `8.26 × 7.93`; top separator at `5.49`; left list icons at `x=1.86`, tops `5.69 / 6.42 / 7.11 / 7.82 / 8.54` (size 0.39), underlines at tops `6.28 / 6.95 / 7.66 / 8.37 / 9.08`; left text Inter 20 bold, right text Inter 24.

```python
def add_two_idea_contrast(prs, title, subtitle, left_title, left_items, right_title, right_lines, skill_dir='.'):
    """S3 template. left_items = [str,...] (icon-bulleted, underlined). right_lines = [(text, bold), ...] (white)."""
    slide = prs.slides.add_slide(get_layout(prs, 'CUSTOM_5_1_1_1_1_1_1_1_2'))  # yellow bg
    strip_placeholders(slide)
    add_textbox(slide, 1.23, 0.43, 17.6, 1.3, [(title.upper(),'Anton',60,False,'0C0C0C',False)])
    add_textbox(slide, 1.28, 1.50, 12.4, 0.6, [(subtitle,'Inter',24,False,'0C0C0C',False)])
    T, W, H = 2.56, 8.26, 7.93
    icon = f'{skill_dir}/assets/icons/icon-black.png'
    round_card(slide, 1.25, T, W, H, 'FFFFFF', adj=0.07889)
    add_textbox(slide, 1.55, T+0.3, W-0.6, 1.4, [(left_title.upper(),'Anton',72,False,'0C0C0C',False)], align=PP_ALIGN.CENTER)
    hline(slide, 1.74, 5.49, 7.24)
    icon_T = [5.69, 6.42, 7.11, 7.82, 8.54]; line_T = [6.28, 6.95, 7.66, 8.37, 9.08]
    for it, iy, ly in zip(left_items, icon_T, line_T):
        slide.shapes.add_picture(icon, Inches(1.86), Inches(iy), Inches(0.39), Inches(0.39))
        add_textbox(slide, 2.45, iy-0.04, 6.4, 0.5, [(it,'Inter',20,True,'0C0C0C',False)])
        hline(slide, 1.74, ly, 7.24, weight=0.75)
    round_card(slide, 10.49, T, W, H, '0C0C0C', adj=0.07889)
    add_textbox(slide, 10.79, T+0.3, W-0.6, 1.4, [(right_title.upper(),'Anton',72,False,'FFFFFF',False)], align=PP_ALIGN.CENTER)
    hline(slide, 10.97, 5.49, 7.24, color='FFFFFF')
    add_textbox(slide, 10.97, 5.85, 7.0, 3.5, [(t,'Inter',24,b,'FFFFFF',False) for (t,b) in right_lines])
    return slide
```

## 4 blocks (2×2 cards with header pills) — S4 style
*Reproduced pixel-for-pixel from the priority deck (S4 "Informations sur le bootcamp").* Use for 4 grouped info blocks (people, agenda, objectives…), not for 4 parallel "ideas".

Light grey background. Four white rounded cards (`adj=0.07889`, soft shadow) in a 2×2 grid, each topped by a **header pill with rounded top corners only** (`MSO_SHAPE.ROUND_2_SAME_RECTANGLE`, `adj≈0.359`) overlapping the card's top edge. Pill colors: **blue `#5B5EFF`** (white text) or **yellow `#EEFF00`** (black text). Each card has a left icon (`people.png` / `notepad.png` / `target.png` in `assets/icons/`) and a content list (Inter 19–20, bulleted or numbered).

Key values: cards `7.99 × 3.40` at TL `(0.77, 2.59)`, TR `(9.99, 2.59)`, BL `(0.77, 6.85)`, BR `(9.99, 6.85)`; header pill `5.31 × 0.63` at `(card_left, card_top-0.52)`, text Inter 18 bold middle-anchored; icon `1.1 × 1.1` at `(card_left+0.2, card_top+1.0)`; content textbox at `card_left+1.55`, middle-anchored.

```python
def add_four_cards(prs, title, cards, skill_dir='.'):
    """S4 template. cards = [(card_left, card_top, header_fill, header_text_color,
        header, icon_name, content, numbered), ...] (4 entries).
        content item = (text,) plain bullet | (name, _, bold_suffix) name+bold role."""
    slide = prs.slides.add_slide(get_layout(prs, 'CUSTOM_5_1'))
    strip_placeholders(slide)
    full_bg(slide, 'F6F6F6')
    add_textbox(slide, 0.77, 0.23, 16.56, 1.3, [(title.upper(),'Anton',60,False,'0C0C0C',False)])
    W, H = 7.99, 3.40
    for (cl, ct, hf, htc, htxt, icon, content, numbered) in cards:
        round_card(slide, cl, ct, W, H, 'FFFFFF', adj=0.07889)
        pill = slide.shapes.add_shape(MSO_SHAPE.ROUND_2_SAME_RECTANGLE, Inches(cl), Inches(ct-0.52), Inches(5.31), Inches(0.63))
        pill.fill.solid(); pill.fill.fore_color.rgb = RGBColor.from_string(hf)
        pill.line.fill.background(); pill.shadow.inherit = False
        try: pill.adjustments[0] = 0.359
        except: pass
        tb = slide.shapes.add_textbox(Inches(cl+0.25), Inches(ct-0.52), Inches(5.0), Inches(0.63))
        tb.text_frame.vertical_anchor = MSO_ANCHOR.MIDDLE
        r = tb.text_frame.paragraphs[0].add_run(); r.text = htxt
        r.font.name='Inter'; r.font.size=Pt(18); r.font.bold=True; r.font.color.rgb=RGBColor.from_string(htc)
        slide.shapes.add_picture(f'{skill_dir}/assets/icons/{icon}.png', Inches(cl+0.2), Inches(ct+1.0), Inches(1.1), Inches(1.1))
        body = slide.shapes.add_textbox(Inches(cl+1.55), Inches(ct+0.85), Inches(W-1.8), Inches(H-1.0))
        bf = body.text_frame; bf.word_wrap = True; bf.vertical_anchor = MSO_ANCHOR.MIDDLE
        for i, item in enumerate(content):
            p = bf.paragraphs[0] if i == 0 else bf.add_paragraph()
            if numbered:
                r = p.add_run(); r.text = f'{i+1}.  {item[0]}'; r.font.name='Inter'; r.font.size=Pt(20); r.font.color.rgb=RGBColor.from_string('0C0C0C')
            elif len(item) == 3:
                r = p.add_run(); r.text = '\u25cf  '+item[0]; r.font.name='Inter'; r.font.size=Pt(19); r.font.color.rgb=RGBColor.from_string('0C0C0C')
                r2 = p.add_run(); r2.text = item[2]; r2.font.name='Inter'; r2.font.size=Pt(19); r2.font.bold=True; r2.font.color.rgb=RGBColor.from_string('0C0C0C')
            else:
                r = p.add_run(); r.text = '\u25cf  '+item[0]; r.font.name='Inter'; r.font.size=Pt(20); r.font.color.rgb=RGBColor.from_string('0C0C0C')
    return slide
```


## 3 ideas — PREFERRED: three cards (S1 style)
*Reproduced pixel-for-pixel from the priority deck (S1 "Une infinité de cas d'usages").*

Yellow background, three **white rounded cards** with a soft drop shadow. Each card: title **Anton 72pt**, a thin black separator line, then a `●`-bulleted list in **Inter 24pt**, with an optional italic caption line at the end. Colors hard-coded (cards white `#FFFFFF`, text/line near-black `#0C0C0C`).

Key exact values: cards at left `1.147 / 7.119 / 13.091`, top `3.329`, size `5.762 × 6.540`, roundRect corner `adj=0.10991`; separator line at top `5.089`, width `4.50`; slide title Anton 60pt at `1.23, 0.43`.

```python
def add_three_idea_cards(prs, title, cards):
    """S1 template. cards = [(card_title, [bullet,...], caption_or_None) x3]."""
    slide = prs.slides.add_slide(get_layout(prs, 'CUSTOM_5_1_1_1_1_1_1_1_2'))  # yellow bg
    strip_placeholders(slide)
    add_textbox(slide, 1.23, 0.43, 17.6, 1.6, [(title.upper(),'Anton',60,False,'0C0C0C',False)])
    geom = [1.147, 7.119, 13.091]; T, W, H = 3.329, 5.762, 6.540
    line_T, line_W = 5.089, 4.50
    for i, (ctitle, bullets, caption) in enumerate(cards):
        L = geom[i]
        round_card(slide, L, T, W, H, 'FFFFFF')
        add_textbox(slide, L+0.5, T+0.25, W-1.0, 1.4, [(ctitle.upper(),'Anton',72,False,'0C0C0C',False)])
        hline(slide, L+0.63, line_T, line_W)
        blines = [(f'\u25cf  {b}','Inter',24,False,'0C0C0C',False) for b in bullets]
        if caption: blines.append((caption,'Inter',24,False,'0C0C0C',True))
        add_textbox(slide, L+0.63, line_T+0.35, W-1.1, H-(line_T-T)-0.5, blines)
    return slide
```

## Timeline / history (S7 style)
*Reproduced from the priority deck (S7 "Historique").* Use for a chronological history or roadmap with several dated milestones.

Light grey background. A thick **yellow right-arrow** across the vertical middle (`y≈5.71`), with N milestones **alternating above/below** (starting above). Each milestone: a black **diamond** on the line, a thin black **stem** to a rounded **date pill** (Anton ~24), and a **caption** (Inter 18) beyond the pill. Pills are light violet **`#E0E0FD`**, except highlighted milestones in blue **`#5B5EFF`** with white text. Fully parametric — pass any list of points.

```python
def add_timeline(prs, title, points):
    """S7 template. points = [(date, caption, highlight_bool), ...] in order; alternates above/below."""
    slide = prs.slides.add_slide(get_layout(prs, 'CUSTOM_5_1'))
    strip_placeholders(slide); full_bg(slide, 'F6F6F6')
    add_textbox(slide, 1.23, 0.43, 17.6, 1.3, [(title.upper(),'Anton',60,False,'0C0C0C',False)])
    LINE_Y, x0, x1 = 5.71, 1.30, 18.0
    n = len(points); step = (x1-x0)/n if n else 0
    arrow = slide.shapes.add_shape(MSO_SHAPE.RIGHT_ARROW, Inches(x0), Inches(LINE_Y-0.16), Inches(x1-x0+0.7), Inches(0.32))
    arrow.fill.solid(); arrow.fill.fore_color.rgb = RGBColor.from_string('EEFF00')
    arrow.line.fill.background(); arrow.shadow.inherit = False
    try: arrow.adjustments[0]=0.6; arrow.adjustments[1]=0.55
    except: pass
    pill_w, pill_h, cap_h = 2.29, 0.62, 1.0
    for i, (date, caption, hl) in enumerate(points):
        cx = x0 + step*i + step*0.5
        above = (i % 2 == 0)
        dia = slide.shapes.add_shape(MSO_SHAPE.DIAMOND, Inches(cx-0.22), Inches(LINE_Y-0.22), Inches(0.44), Inches(0.44))
        dia.fill.solid(); dia.fill.fore_color.rgb = RGBColor.from_string('0C0C0C'); dia.line.fill.background(); dia.shadow.inherit = False
        if above:
            stem_top, stem_h = LINE_Y-1.05, 1.05; pill_t = stem_top-pill_h; cap_t = pill_t-cap_h+0.15
        else:
            stem_top, stem_h = LINE_Y, 1.05; pill_t = LINE_Y+1.05; cap_t = pill_t+pill_h-0.05
        stem = slide.shapes.add_shape(MSO_SHAPE.RECTANGLE, Inches(cx-0.045), Inches(stem_top), Inches(0.09), Inches(stem_h))
        stem.fill.solid(); stem.fill.fore_color.rgb = RGBColor.from_string('0C0C0C'); stem.line.fill.background(); stem.shadow.inherit = False
        pill_fill = '5B5EFF' if hl else 'E0E0FD'; pill_txt = 'FFFFFF' if hl else '0C0C0C'
        rc = slide.shapes.add_shape(MSO_SHAPE.ROUNDED_RECTANGLE, Inches(cx-pill_w/2), Inches(pill_t), Inches(pill_w), Inches(pill_h))
        rc.fill.solid(); rc.fill.fore_color.rgb = RGBColor.from_string(pill_fill); rc.line.fill.background(); rc.shadow.inherit = False
        try: rc.adjustments[0]=0.5
        except: pass
        # date (Anton, middle/center) and caption (Inter)
        for (box_t, box_h, txt, fn, sz, col) in [(pill_t, pill_h, date,'Anton',24,pill_txt),(cap_t, cap_h, caption,'Inter',18,'0C0C0C')]:
            tb = slide.shapes.add_textbox(Inches(cx-1.4), Inches(box_t), Inches(2.8), Inches(box_h))
            tf = tb.text_frame; tf.word_wrap=True; tf.vertical_anchor=MSO_ANCHOR.MIDDLE
            for j, line in enumerate(txt.split('\n')):
                p = tf.paragraphs[0] if j==0 else tf.add_paragraph(); p.alignment=PP_ALIGN.CENTER
                r = p.add_run(); r.text = line.upper() if fn == 'Anton' else line; r.font.name=fn; r.font.size=Pt(sz); r.font.color.rgb=RGBColor.from_string(col)
    return slide
```



---

## Price / options table (S8 style)
*Reproduced pixel-for-pixel from the priority deck (S8 "Budget Reelevant - Options").* Use for a pricing grid or options comparison.

Light grey background **with the black slanted footer** (`add_footer`). Two header bars: left **black `#0C0C0C`** ("PRODUIT"), right **blue `#5B5EFF`** ("PRIX (€) HT"), both Anton 25 white centered, at top `3.10`, height `0.53` (left width 12.20, right at left `13.55` width 4.60). Below, a 3-column table (col widths `5.18 / 7.14 / 4.60`) at `1.23, 3.96`: col0 = dark grey `#434343` channel cells (Anton 20, white, centered), col1 = light `#F6F6F6` descriptions (Inter 20, left), col2 = `#EFEFEF` prices (Inter 20 **bold**, centered). An optional grouped section merges col0 into one medium-grey `#999999` label spanning its rows. **Every cell gets a light grey `#D9D9D9` border.**

```python
from pptx.oxml.ns import qn
from pptx.oxml import parse_xml

def add_footer(slide):
    """Black slanted footer (flowChartManualInput), matching the S16/S17 content layouts."""
    sh = slide.shapes.add_shape(MSO_SHAPE.FLOWCHART_MANUAL_INPUT, Inches(-0.06), Inches(9.54), Inches(20.18), Inches(4.48))
    sh.fill.solid(); sh.fill.fore_color.rgb = RGBColor.from_string('0C0C0C'); sh.line.fill.background(); sh.shadow.inherit = False
    return sh

def set_cell_border(cell, color='D9D9D9', width_pt=0.75):
    tcPr = cell._tc.get_or_add_tcPr()
    for tag in ('a:lnL','a:lnR','a:lnT','a:lnB'):
        for e in tcPr.findall(qn(tag)): tcPr.remove(e)
    w = int(width_pt*12700)
    for tag in ('lnB','lnT','lnR','lnL'):  # insert reversed -> final order lnL,lnR,lnT,lnB
        tcPr.insert(0, parse_xml(f'<a:{tag} xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main" w="{w}" cap="flat" cmpd="sng" algn="ctr"><a:solidFill><a:srgbClr val="{color}"/></a:solidFill><a:prstDash val="solid"/></a:{tag}>'))

def add_price_table(prs, title, left_header, right_header, rows, group_label=None, group_rows=None):
    """S8 template. rows = [(channel_lines, desc, price), ...].
    group_label / group_rows: optional merged-label section, group_rows = [(desc, price), ...]."""
    slide = prs.slides.add_slide(get_layout(prs, 'CUSTOM_5_1'))
    strip_placeholders(slide); full_bg(slide, 'F6F6F6')
    add_textbox(slide, 1.23, 0.43, 17.6, 1.3, [(title.upper(),'Anton',60,False,'0C0C0C',False)])
    def bar(l, w, fill, txt):
        sh = slide.shapes.add_shape(MSO_SHAPE.RECTANGLE, Inches(l), Inches(3.10), Inches(w), Inches(0.53))
        sh.fill.solid(); sh.fill.fore_color.rgb = RGBColor.from_string(fill); sh.line.fill.background(); sh.shadow.inherit = False
        tf = sh.text_frame; tf.vertical_anchor = MSO_ANCHOR.MIDDLE
        r = tf.paragraphs[0].add_run(); r.text = txt.upper(); tf.paragraphs[0].alignment = PP_ALIGN.CENTER
        r.font.name='Anton'; r.font.size=Pt(25); r.font.color.rgb=RGBColor.from_string('FFFFFF')
    bar(1.23, 12.20, '0C0C0C', left_header)
    bar(13.55, 4.60, '5B5EFF', right_header)
    nrows = len(rows) + (len(group_rows) if group_rows else 0)
    tbl = slide.shapes.add_table(nrows, 3, Inches(1.23), Inches(3.96), Inches(16.92), Inches(3.1)).table
    tbl.first_row = False; tbl.horz_banding = False
    tbl.columns[0].width=Inches(5.18); tbl.columns[1].width=Inches(7.14); tbl.columns[2].width=Inches(4.60)
    def put(cell, lines, fill, font, size, bold, color, align):
        cell.fill.solid(); cell.fill.fore_color.rgb = RGBColor.from_string(fill)
        tf = cell.text_frame; tf.word_wrap = True; tf.vertical_anchor = MSO_ANCHOR.MIDDLE
        for i, ln in enumerate(lines):
            p = tf.paragraphs[0] if i == 0 else tf.add_paragraph(); p.alignment = align
            r = p.add_run(); r.text = ln.upper() if font == 'Anton' else ln; r.font.name=font; r.font.size=Pt(size); r.font.bold=bold; r.font.color.rgb=RGBColor.from_string(color)
    ri = 0
    for (chan_lines, desc, price) in rows:
        put(tbl.cell(ri,0), chan_lines, '434343', 'Anton', 20, False, 'FFFFFF', PP_ALIGN.CENTER)
        put(tbl.cell(ri,1), [desc], 'F6F6F6', 'Inter', 20, False, '0C0C0C', PP_ALIGN.LEFT)
        put(tbl.cell(ri,2), [price], 'EFEFEF', 'Inter', 20, True, '0C0C0C', PP_ALIGN.CENTER)
        ri += 1
    if group_rows:
        start = ri
        for (desc, price) in group_rows:
            put(tbl.cell(ri,1), [desc], 'F6F6F6', 'Inter', 20, False, '0C0C0C', PP_ALIGN.LEFT)
            put(tbl.cell(ri,2), [price], 'EFEFEF', 'Inter', 20, True, '0C0C0C', PP_ALIGN.CENTER)
            ri += 1
        c0 = tbl.cell(start, 0); c0.merge(tbl.cell(ri-1, 0))
        put(c0, [group_label], '999999', 'Anton', 20, False, 'FFFFFF', PP_ALIGN.CENTER)
    for r in tbl.rows: r.height = Inches(0.62)
    for rr in range(nrows):
        for cc in range(3): set_cell_border(tbl.cell(rr,cc), 'D9D9D9', 0.75)
    add_footer(slide)
    return slide
```

## Maturity pyramid + side cards (S9 style)
*Reproduced from the priority deck (S9 "Est considéré comme hyper-personnalisé").* Use for a 3-level maturity / hierarchy model with explanatory cards.

Light grey background **with the black footer**. The bundled **low-poly 3D pyramid** (`add_pyramid_3d`, see `content-layouts.md`) sits centre, at `left=6.11, top=2.66, width=6.86`. Three cards (white rounded body + **yellow `#EEFF00`** rounded-top header pill, Anton 24): top-right, bottom-right, and left. **The white body starts ~0.43" below the pill top so the pill's rounded top corners reveal the grey background (only the yellow shows).** Numbered black circle **badges** (1/2/3) on short grey connector lines link each tier to its card.

Card positions: HYPER (badge 1) `13.41, 1.80` size `6.04×2.95`; GÉNÉRIQUE (badge 3) `13.41, 5.28` size `6.04×2.95`; PERSONNALISATION (badge 2) `1.14, 3.28` size `4.53×3.85`; pill height `0.86`.

```python
def card_with_pill(slide, l, t, w, body_h, pill_h, title, body_lines):
    radius = 0.43  # body starts below the pill's rounded-corner zone -> grey bg shows at pill top corners
    body = slide.shapes.add_shape(MSO_SHAPE.ROUNDED_RECTANGLE, Inches(l), Inches(t+radius), Inches(w), Inches(body_h-radius))
    body.fill.solid(); body.fill.fore_color.rgb = RGBColor.from_string('FFFFFF'); body.line.fill.background(); body.shadow.inherit = False
    try: body.adjustments[0] = 0.06
    except: pass
    pill = slide.shapes.add_shape(MSO_SHAPE.ROUND_2_SAME_RECTANGLE, Inches(l), Inches(t), Inches(w), Inches(pill_h))
    pill.fill.solid(); pill.fill.fore_color.rgb = RGBColor.from_string('EEFF00'); pill.line.fill.background(); pill.shadow.inherit = False
    try: pill.adjustments[0] = 0.5
    except: pass
    tf = pill.text_frame; tf.vertical_anchor = MSO_ANCHOR.MIDDLE
    r = tf.paragraphs[0].add_run(); r.text = title.upper(); tf.paragraphs[0].alignment = PP_ALIGN.CENTER
    r.font.name='Anton'; r.font.size=Pt(24); r.font.color.rgb=RGBColor.from_string('0C0C0C')
    tb = slide.shapes.add_textbox(Inches(l+0.3), Inches(t+pill_h+0.1), Inches(w-0.6), Inches(body_h-pill_h-0.2))
    add_textbox_into(tb, body_lines, 'Inter', 18, '0C0C0C')  # top-anchored body text

def connector_badge(slide, x_from, x_to, y, num):
    ln = slide.shapes.add_connector(2, Inches(x_from), Inches(y), Inches(x_to), Inches(y))
    ln.line.color.rgb = RGBColor.from_string('C2C2C2'); ln.line.width = Pt(1.5)
    e = slide.shapes.add_shape(MSO_SHAPE.OVAL, Inches(x_to-0.18), Inches(y-0.18), Inches(0.36), Inches(0.36))
    e.fill.solid(); e.fill.fore_color.rgb = RGBColor.from_string('0C0C0C'); e.line.fill.background(); e.shadow.inherit = False
    tf = e.text_frame; tf.vertical_anchor = MSO_ANCHOR.MIDDLE
    r = tf.paragraphs[0].add_run(); r.text = str(num); tf.paragraphs[0].alignment = PP_ALIGN.CENTER
    r.font.name='Anton'; r.font.size=Pt(16); r.font.color.rgb=RGBColor.from_string('FFFFFF')

def add_maturity_pyramid(prs, title, hyper, perso, generic, skill_dir='.'):
    """S9 template. hyper/perso/generic = description string for each card."""
    slide = prs.slides.add_slide(get_layout(prs, 'CUSTOM_5_1'))
    strip_placeholders(slide); full_bg(slide, 'F6F6F6')
    add_textbox(slide, 1.23, 0.43, 17.6, 1.3, [(title.upper(),'Anton',60,False,'0C0C0C',False)])
    add_pyramid_3d(slide, 6.11, 2.66, 6.86, skill_dir)   # see content-layouts.md
    card_with_pill(slide, 13.41, 1.80, 6.04, 2.95, 0.86, 'HYPER- PERSONNALISATION', [hyper])
    card_with_pill(slide, 13.41, 5.28, 6.04, 2.95, 0.86, 'GÉNÉRIQUE (AUTOMATISATION)', [generic])
    card_with_pill(slide, 1.14, 3.28, 4.53, 3.85, 0.86, 'PERSONNALISATION', [perso])
    connector_badge(slide, 11.6, 13.3, 3.25, 1)   # apex -> hyper
    connector_badge(slide, 6.3, 5.75, 4.6, 2)      # mid -> perso (badge just outside the left card)
    connector_badge(slide, 11.9, 13.3, 6.7, 3)     # base -> générique
    add_footer(slide)
    return slide
```

Requires `add_pyramid_3d` and `add_freeform_poly` from `content-layouts.md`.

---

## Selection rule (summary)

Approved library designs now available:
- **2 ideas** → comparison cards (S2) or contrast cards (S3) — alternate between them.
- **3 ideas** → three feature cards (S1).
- **4 grouped info blocks** → 2×2 cards with header pills (S4).
- **chronological history / roadmap** → timeline (S7).
- **pricing grid / options** → price table (S8).
- **3-level maturity / hierarchy model** → maturity pyramid + side cards (S9).
- **1 idea / other counts** → no dedicated design yet; fall back to `content-layouts.md`.

1. Count the distinct ideas (or recognise a timeline / 4-block / table / pyramid case).
2. If a matching approved design exists, use it as the first choice.
3. Otherwise fall back to the generic patterns in `content-layouts.md`.
4. **Vary** — don't repeat the same library layout on consecutive same-idea-count slides.
5. When building a library layout: clean background (`full_bg` on the light one). Most carry the black slanted footer via `add_footer` (S8/S9); the card layouts (S1–S4) don't.
6. Respect the **two-color rule**.
