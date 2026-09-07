---
name: reelevant-slides
description: >
  Generate Reelevant-branded slide presentations with python-pptx from the New Masque 2026 template and always deliver both the PDF and the PPTX. Trigger when the user asks to create a presentation, deck, slides, or pitch. Never build slides from scratch — always build on the template's slide layouts.
---

# Reelevant Slides — Generation Guide

This skill tells Devin how to generate slide decks using the **New Masque 2026** template. Never invent layouts from scratch — always build on top of the template's slide layouts.

---

## Output Format — PDF + PPTX (NON-NEGOTIABLE)

**Always deliver both files.** Convert the generated PPTX to PDF with LibreOffice and attach **the PDF and the PPTX** to the user in the same `message_user` call. Never hand back only one of them. See "Delivering the Deck" below.

---

## Setup

Always use `python-pptx`. Never use `pptxgenjs` for Reelevant decks, it can't inherit the slide master.

### Dependencies

Install once per session (all three are required for a faithful PDF):

```bash
pip install python-pptx
sudo apt-get update && sudo apt-get install -y libreoffice-impress poppler-utils   # PPTX -> PDF conversion + pdftoppm for previews
# Brand fonts (Anton, Inter, Instrument Serif) — without them LibreOffice substitutes
# fonts and the PDF layout drifts. Fetch them from the Google Fonts repo:
mkdir -p ~/.fonts && cd ~/.fonts && \
  curl -sSLO https://github.com/google/fonts/raw/main/ofl/anton/Anton-Regular.ttf && \
  curl -sSLO 'https://github.com/google/fonts/raw/main/ofl/inter/Inter%5Bopsz%2Cwght%5D.ttf' && \
  curl -sSLO https://github.com/google/fonts/raw/main/ofl/instrumentserif/InstrumentSerif-Regular.ttf && \
  curl -sSLO https://github.com/google/fonts/raw/main/ofl/instrumentserif/InstrumentSerif-Italic.ttf && \
  fc-cache -f && fc-list | grep -E 'Anton|Inter|Instrument'
```

### Paths and working directory (read this first)

This skill lives in the `product-documentation` repo at `.agents/skills/reelevant-slides/`. Your generation code does **not** run from inside it. Two consequences that will silently break the deck if ignored:

- Relative paths like `assets/New_Masque_2026.pptx` will not resolve. Load every asset (template, icons, shapes) through an **absolute** path built from `SKILL_DIR`.
- Every helper that takes a `skill_dir` argument must receive `SKILL_DIR`, never its default `'.'`. The `skill_dir='.'` in the code samples is a placeholder, not a usable value. Helpers concerned: `add_agenda`, `add_two_idea_contrast`, `add_four_cards`, `add_maturity_pyramid`, and any other asset-loading layout.

Set these two variables once at the top of your script and reuse them everywhere:

```python
from pptx import Presentation
from pptx.util import Pt, Inches, Emu
from pptx.dml.color import RGBColor
from pptx.enum.text import PP_ALIGN
import copy, os

# Absolute path to this skill directory inside the repo checkout.
SKILL_DIR  = os.path.expanduser('~/repos/product-documentation/.agents/skills/reelevant-slides')
OUTPUT_DIR = os.path.expanduser('~/slides-output')   # writable; NEVER write inside SKILL_DIR or the repo
os.makedirs(OUTPUT_DIR, exist_ok=True)

TEMPLATE = os.path.join(SKILL_DIR, 'assets', 'New_Masque_2026.pptx')
prs = Presentation(TEMPLATE)
```

If the repo is not cloned yet, clone `https://github.com/reelevant-tech/product-documentation.git` (only the skill directory is needed).

---

## Saving

The template contains **1 blank placeholder slide** (required by Google Slides for download). Remove it before saving:

```python
output_path = os.path.join(OUTPUT_DIR, 'deck.pptx')  # writable location, never SKILL_DIR
prs.slides._sldIdLst.remove(list(prs.slides._sldIdLst)[0])
prs.save(output_path)
```

Then convert to PDF (see "Delivering the Deck").

---

## Upfront Questions

Before generating, always ask the user:
1. **How many slides?** (ask explicitly — don't guess)

---

## ⚠️ ARCHITECTURE: LIBRARY-FIRST — BEFORE YOU CODE ANYTHING

**This is the single most important rule. Read this before you start writing any slide generation code.**

### The rule (non-negotiable)
Every slide you generate must use an approved library layout if one exists for that idea-count or shape. Generic custom layouts (rectangles + textboxes) are a last resort when the library has no fit. **If you write a single line of code that goes `add_rect + add_textbox` without checking the library first, that is a bug in your code.**

### The checkpoint (in your head, every time)
Before you write ANY layout code for a slide, pause and ask yourself:
1. **How many distinct ideas / sections / blocks does this slide hold?** (count them)
2. **Open `references/slide-library.md` and check that count.** Is there a slot?
3. **If yes, use it.** Full stop. Reframe your content to fit if needed.
4. **If no, check `references/content-layouts.md` for a generic pattern** and use that.
5. **Only if neither the library nor the generic patterns fit, then write custom code.**

This hierarchy is strict: **Library > Generic Patterns > Custom.**

### Why?
The library exists precisely because these layouts have been designed, tested, and refined in real decks. Reinventing a 2-block side-by-side layout (which has an approved design — S2 or S3) is slower, uglier, and creates visual debt. Every custom layout drifts from the brand. Don't drift. Use the library.

### The anti-pattern you'll be tempted toward
You'll find yourself writing code like this:
```python
slide = add_content_slide(prs, 'white', 'My Title')
# two blocks side by side
add_rect(slide, 1.23, 1.75, 8.26, 7.0, fill='FFFFFF')
add_textbox(slide, 1.5, 2.0, 7.8, 6.5, 'LEFT CONTENT', ...)
add_rect(slide, 9.49, 1.75, 8.26, 7.0, fill='0C0C0C')
add_textbox(slide, 9.7, 2.0, 7.8, 6.5, 'RIGHT CONTENT', ...)
```

**STOP.** This is a 2-idea slide. Go open `references/slide-library.md`, find S2 (comparison) or S3 (contrast), and use that instead. The library code does all of this for you — centered, calibrated, pixel-perfect.

---

## Slide Dimensions

**20.00" × 11.25"** (18,288,000 × 10,287,000 EMU)
Inherited from the template — do not override.

---


## Font Sizes — NON-NEGOTIABLE DEFAULTS

**These are hard rules, not guidelines. Every text run in a generated deck must satisfy them. Do not size down to fit content — split across slides, shorten copy, or enlarge the container instead.**

### Anton — ALWAYS UPPERCASE
Every Anton run must be uppercase, **in every context, with no exceptions**: titles, section dividers, punchlines, headers, labels, pill text, table headers, axis labels, anything. When passing text to an Anton run, call `.upper()` on it. If you find yourself writing `r.font.name = 'Anton'` without `.upper()` somewhere nearby, that is a bug.

### Inter — DEFAULT 24pt
**Inter body text defaults to 24pt. Period.** This applies to every Inter run unless one of the narrow exceptions below applies. Sizes 18, 20, 21, 22 are **not acceptable defaults** — they were used in past decks because the content didn't fit and the size got nudged down. That is the wrong fix. The right fix is to shorten the copy or split the slide.

The **only** acceptable cases for Inter under 24pt:
- **Library layouts** — when reproducing a layout from `references/slide-library.md`, keep its specified font sizes (e.g. Inter 20 bold on S3 contrast). Library coordinates are pixel-calibrated to those sizes; bumping them will overflow separator lines and break the geometry. See the "Library layouts override the Inter 24pt default" note in the library section for the full rule.
- **Table cells** (16–18pt) — dense rows, multiple columns
- **Image / chart captions** (16–18pt) — short labels under a visual
- **Footnotes, sources, legal lines** (14–16pt)
- **Pill text inside small header pills** (18pt, per S4 library spec)

That's it. A 3-column content card with a paragraph below the header is **not** a caption — it is body text and must be 24pt. If three columns of 24pt Inter don't fit, the slide carries too much copy.

### Required Sizes Table

| Context | Font | Size |
|---------|------|------|
| **Cover title (S3)** | Anton | **80pt** (was 96pt — 96pt clips on long words) |
| **Section divider — short title (<5 words)** | Anton | **120pt** |
| **Section divider — long title (5+ words), line 1** | Instrument Serif (italic, Aa) | **96pt** |
| **Section divider — long title (5+ words), line 2** | Anton | **120pt** |
| **Standard slide title (S16/S17)** | Anton | **60pt** |
| **Closing title (S26/S27)** | Anton | **72pt** |
| **Punchline (S11/S12)** | Anton | **96pt** |
| **Column / block / card header** | Anton | **24–28pt** |
| **Body text (default)** | Inter | **24pt — NON-NEGOTIABLE** |
| **Subtitle / pull quote** | Instrument Serif | 24–28pt |
| **Table cell / caption / footnote (exception only)** | Inter | 16–18pt |

The cover (S3) and the closing slide (S26/S27) have no subtitle — title only.

### Self-check before saving
Before calling `prs.save()`, mentally run this checklist on every slide:
1. Every Anton run is uppercase. ✅
2. Every Inter run is 24pt, unless it falls in the narrow exception list above. ✅
3. No title is below the required size for its slide type. ✅

If any check fails, fix the code — do not ship the deck.

---

## Available Slide Types

```python
def get_layout(prs, name):
    for layout in prs.slide_layouts:
        if layout.name == name:
            return layout
    raise ValueError(f"Layout '{name}' not found")

slide = prs.slides.add_slide(get_layout(prs, LAYOUT_NAME))
```

### Slide Type Reference

| Type | Layout Name | Placeholders | When to use |
|------|-------------|--------------|-------------|
| **Cover** | `Title Slide_1_1_1` | Title (idx=0), Picture (idx=2) | First slide always (S3) |
| **Table of Contents** | `1_Title Slide_2` | Title (idx=0), Items idx=1–9,14–16 | Optional overview (S5) |
| **Section — White** | `1_Title Slide_1_3_1` | none | Section dividers (S7) |
| **Section — Yellow** | `1_Title Slide_1_3_1_1` | none | Section dividers (S8) |
| **Section — Blue** | `1_Title Slide_1_3_1_2` | none | Section dividers (S9) |
| **Punchline — Black** | `5_Title Slide_1_1_1_1` | Body (idx=1) at bottom | Standout messages (S11) |
| **Punchline — Yellow** | `5_Title Slide_1_2_1` | Body (idx=1) at bottom | Standout messages (S12) |
| **Content — White** | `CUSTOM_5_1_1_2` | Title (idx=0) top | Main content slides (S16) |
| **Content — Yellow footer** | `CUSTOM_5_1_1_2_2` | Title (idx=0) top | Main content slides (S17) |
| **Closing — Black** | `11_Title Slide_1` | Title (idx=0), Subtitle (idx=1) | End of deck (S26) |
| **Closing — Yellow** | `11_Title Slide_1_1` | none | End of deck (S27) |

---

## Placeholder Positions (for reference)

| Slide | Placeholder | left | top | width | height |
|-------|-------------|------|-----|-------|--------|
| Cover (S3) | Title idx=0 | 1.71" | 1.44" | 6.65" | 2.03" |
| Cover (S3) | Picture idx=2 | 1.71" | 6.82" | 5.67" | 1.25" |
| Content S16/S17 | Title idx=0 | 1.23" | 0.43" | 17.60" | 1.15" |
| Punchline S11/S12 | Body idx=1 | 1.00" | 6.07" | 14.36" | 3.66" |
| Closing S26 | Title idx=0 | 0.33" | 1.09" | 14.96" | 1.56" |
| Closing S26 | Subtitle idx=1 | 0.33" | 2.20" | 7.20" | 1.07" |

---

## Section Dividers (S7, S8, S9) — No Placeholders

Add a text box on top of the layout background. **Title sizing depends on word count:**
- **Short title (fewer than 5 words):** single line, Anton UPPERCASE at 120pt.
- **Long title (5 words or more):** two lines — first line in Instrument Serif italic at 96pt (normal case Aa), second line in Anton UPPERCASE at 120pt. Split the title roughly in half across the two lines.

```python
def add_section_divider(prs, color='yellow', title='SECTION TITLE'):
    layout_map = {
        'white':  '1_Title Slide_1_3_1',
        'yellow': '1_Title Slide_1_3_1_1',
        'blue':   '1_Title Slide_1_3_1_2',
    }
    text_colors = {'white': '0C0C0C', 'yellow': '0C0C0C', 'blue': 'FFFFFF'}
    slide = prs.slides.add_slide(get_layout(prs, layout_map[color]))
    color_hex = text_colors[color]
    words = title.split()

    if len(words) >= 5:
        # Two-line format: Instrument Serif (line 1) + Anton caps (line 2)
        mid = (len(words) + 1) // 2
        line1 = ' '.join(words[:mid])
        line2 = ' '.join(words[mid:])
        tb = slide.shapes.add_textbox(Inches(1.23), Inches(3.0), Inches(17), Inches(5.0))
        tf = tb.text_frame; tf.word_wrap = True
        p1 = tf.paragraphs[0]
        r1 = p1.add_run(); r1.text = line1           # normal case (Aa)
        r1.font.name = 'Instrument Serif'; r1.font.size = Pt(96); r1.font.italic = True
        r1.font.color.rgb = RGBColor.from_string(color_hex)
        p2 = tf.add_paragraph()
        r2 = p2.add_run(); r2.text = line2.upper()    # UPPERCASE
        r2.font.name = 'Anton'; r2.font.size = Pt(120); r2.font.bold = False
        r2.font.color.rgb = RGBColor.from_string(color_hex)
    else:
        # Short title: single line, Anton caps 120
        tb = slide.shapes.add_textbox(Inches(1.23), Inches(3.8), Inches(17), Inches(3.5))
        tf = tb.text_frame; tf.word_wrap = True
        p = tf.paragraphs[0]
        r = p.add_run(); r.text = title.upper()
        r.font.name = 'Anton'; r.font.size = Pt(120); r.font.bold = False
        r.font.color.rgb = RGBColor.from_string(color_hex)
    return slide
```

---

## Agenda Slide (REQUIRED for 4+ part decks)

**If the presentation has four or more parts/sections, always include an agenda slide right after the cover.** For decks with fewer than four parts, skip the agenda.

Build the agenda on the yellow section background and use the **small black Reelevant icon** (`assets/icons/icon-black.png`) as the bullet point for each item (the template's table-of-contents layout has decorative icon placeholders inherited from the layout that can't be cleanly removed, so build the items yourself for full control):

```python
def add_agenda(prs, parts, title='AGENDA', skill_dir='.'):
    """parts: list of section names. Use only when the deck has 4+ parts."""
    slide = prs.slides.add_slide(get_layout(prs, '1_Title Slide_1_3_1_1'))  # yellow bg
    icon = f'{skill_dir}/assets/icons/icon-black.png'
    # Title
    tb = slide.shapes.add_textbox(Inches(1.23), Inches(1.0), Inches(14), Inches(1.4))
    p = tb.text_frame.paragraphs[0]
    r = p.add_run(); r.text = title.upper()
    r.font.name = 'Anton'; r.font.size = Pt(72); r.font.bold = False
    r.font.color.rgb = RGBColor(0x0C, 0x0C, 0x0C)
    # Items, each bulleted with the Reelevant icon
    n = len(parts)
    y0 = 2.9
    gap = min(1.3, (8.2 - y0) / n) if n > 4 else 1.2
    icon_sz = 0.55
    for i, part in enumerate(parts):
        y = y0 + i * gap
        slide.shapes.add_picture(icon, Inches(1.23), Inches(y), Inches(icon_sz), Inches(icon_sz))
        lb = slide.shapes.add_textbox(Inches(2.2), Inches(y - 0.02), Inches(15), Inches(0.7))
        lp = lb.text_frame.paragraphs[0]
        lr = lp.add_run(); lr.text = part
        lr.font.name = 'Inter'; lr.font.size = Pt(26); lr.font.color.rgb = RGBColor(0x0C, 0x0C, 0x0C)
    return slide
```

The agenda uses the yellow section background, so it counts as a yellow+black slide (respects the two-color rule). Supports up to ~8 parts; the `gap` shrinks automatically as the count grows.

---

## Content Slides (S16/S17) — Workhorse Slides

Title at top, free content area below ~1.6".

**Footer safe zone:** the S16/S17 content layouts (and several others) have a slanted black footer at the bottom of the slide. It starts around top=9.54" but, being slanted, rises higher on one side. **Keep all content above ~9.2"** — never place text or shapes lower, or they collide with the footer. With the 1.6" top and ~9.2" bottom limits, the usable content band is roughly **1.6"–9.2"** tall. If content doesn't fit, split across two slides rather than pushing into the footer.

```python
def add_content_slide(prs, variant='white', title='SLIDE TITLE'):
    layout_name = 'CUSTOM_5_1_1_2' if variant == 'white' else 'CUSTOM_5_1_1_2_2'
    slide = prs.slides.add_slide(get_layout(prs, layout_name))
    title_ph = slide.placeholders[0]
    title_ph.text = title.upper()
    for para in title_ph.text_frame.paragraphs:
        for run in para.runs:
            run.font.name = 'Anton'
            run.font.size = Pt(60)
            run.font.bold = False
            run.font.color.rgb = RGBColor(0x0C, 0x0C, 0x0C)
    return slide

def add_textbox(slide, left_in, top_in, w_in, h_in, text,
                font='Inter', size=24, bold=False, color='0C0C0C', italic=False):
    from pptx.enum.text import PP_ALIGN
    txBox = slide.shapes.add_textbox(Inches(left_in), Inches(top_in), Inches(w_in), Inches(h_in))
    tf = txBox.text_frame
    tf.word_wrap = True
    p = tf.paragraphs[0]
    run = p.add_run()
    run.text = text
    run.font.name = font
    run.font.size = Pt(size)
    run.font.bold = bold
    run.font.italic = italic
    run.font.color.rgb = RGBColor.from_string(color)
    return txBox

def add_rect(slide, left_in, top_in, w_in, h_in, fill='EEFF00', line=None):
    shape = slide.shapes.add_shape(1, Inches(left_in), Inches(top_in), Inches(w_in), Inches(h_in))
    shape.fill.solid()
    shape.fill.fore_color.rgb = RGBColor.from_string(fill)
    if line:
        shape.line.color.rgb = RGBColor.from_string(line)
    else:
        shape.line.fill.background()
    return shape
```

**Consistency rule:** Within a section, if you started with S16 (white), stay on S16. Do not mix S16 and S17 within the same section.

**Creative freedom:** S16/S17 are the emptiest slides — Devin may be creative here with layout, shapes, and text boxes. But still respect the two-color rule below.

---

## Punchline Slides (S11/S12)

```python
def add_punchline(prs, variant='black', text='YOUR PUNCHLINE HERE'):
    layout_name = '5_Title Slide_1_1_1_1' if variant == 'black' else '5_Title Slide_1_2_1'
    slide = prs.slides.add_slide(get_layout(prs, layout_name))
    body_ph = slide.placeholders[1]
    body_ph.text = text
    for para in body_ph.text_frame.paragraphs:
        for run in para.runs:
            run.font.name = 'Anton'
            run.font.size = Pt(96)
            run.font.bold = False
            run.font.color.rgb = RGBColor.from_string('FFFFFF' if variant == 'black' else '0C0C0C')
    return slide
```

---

## Cover Slide (S3)

**No subtitle on the cover.** The title only.

The cover layout has an image motif on the right side. The default title placeholder (6.65" wide) is too narrow for long words in Anton 96pt — words like "RELATION" get broken mid-word. Widen the placeholder and keep the title in the left portion so it never overlaps the image.

```python
def add_cover(prs, title='PRESENTATION TITLE'):
    slide = prs.slides.add_slide(get_layout(prs, 'Title Slide_1_1_1'))
    title_ph = slide.placeholders[0]
    # Widened + repositioned so long Anton words like "ENTREPRISE" don't get
    # clipped by the cover image, and the title stays clear of the image area.
    title_ph.left = Inches(1.0)
    title_ph.top = Inches(1.0)
    title_ph.width = Inches(14.5)
    title_ph.height = Inches(6.5)
    title_ph.text_frame.word_wrap = True
    title_ph.text = title.upper()
    for para in title_ph.text_frame.paragraphs:
        for run in para.runs:
            run.font.name = 'Anton'
            run.font.size = Pt(80)
            run.font.bold = False
            run.font.color.rgb = RGBColor(0x0C, 0x0C, 0x0C)
    return slide
```

**Cover font size: 80pt (not 96pt).** Earlier 96pt clipped long words like "ENTREPRISE" against the right-side image. 80pt with the widened placeholder above is the validated default.

**Title length:** keep the cover title short (2–3 words per line max). Insert manual line breaks (`\n`) for clean wrapping rather than relying on auto-wrap, e.g. `'Gestion de la\nRelation Client'`. Never let the title run under the image area on the right.

---

## Closing Slides (S26/S27)

**No subtitle on the closing slide — title only.** Use the **black** closing (`11_Title Slide_1`) when you want a titled closing slide ("Merci", a final statement, etc.).

```python
def add_closing(prs, title='THANK YOU'):
    slide = prs.slides.add_slide(get_layout(prs, '11_Title Slide_1'))
    title_ph = slide.placeholders[0]
    title_ph.text = title.upper()
    for para in title_ph.text_frame.paragraphs:
        for run in para.runs:
            run.font.name = 'Anton'
            run.font.size = Pt(72)
            run.font.bold = False
            run.font.color.rgb = RGBColor(0xEE, 0xFF, 0x00)
    return slide
```

## Final Brand Slide (the "make it" image) — NO TEXT

The deck's very last slide should be the Reelevant brand image slide ("make it personal, make it relevant, make it last"). This is layout `11_Title Slide_1_1`. **Add nothing to it — no title, no text box, no shapes.** The image is the whole slide; any overlaid text ruins it.

```python
def add_final_brand_slide(prs):
    """The closing brand image. Add NOTHING on top of it."""
    return prs.slides.add_slide(get_layout(prs, '11_Title Slide_1_1'))
```

Typical ending: an `add_closing(...)` titled slide, then `add_final_brand_slide(prs)` as the true last slide. (You may also end directly on the brand image alone.)

---

## Color Rule: Two Dominant Colors Per Slide

**Never use all three dominant colors (yellow #EEFF00, blue/violet #5B5EFF, black #0C0C0C) prominently on the same slide.** A very small, subtle accent of the third is acceptable but must be minimal.

| Background | Primary text/elements | Accent (max subtle) |
|------------|----------------------|---------------------|
| Yellow | Black | Blue only if tiny |
| Black | Yellow or white | Blue only if tiny |
| Blue | White | Yellow only if tiny |
| White/light | Black + yellow OR black + blue | Not both |

---

## Typical Deck Structure

```
Cover (S3)
  ↓
Agenda — REQUIRED if the deck has 4+ parts, otherwise skip
  ↓
Section Divider (S7/S8/S9)
  ↓
Content slides (S16 or S17) — same variant throughout section
  ↓
[Optional] Punchline (S11 or S12)
  ↓
Next Section Divider (S7/S8/S9)
  ↓
...
  ↓
Closing (S26 or S27)
```

Rule of thumb: count the section dividers. **4 or more sections → add an agenda slide right after the cover, listing those sections.** Fewer than 4 → no agenda.

---

## Delivering the Deck

**Always attach both the PDF and the PPTX.** Convert the saved PPTX with LibreOffice, then attach the two files together.

```bash
soffice --headless --convert-to pdf --outdir ~/slides-output ~/slides-output/deck.pptx
```

### Flow
1. Save the PPTX to `OUTPUT_DIR`.
2. Run the `soffice` command above; it writes `deck.pdf` next to the PPTX.
3. **Check the PDF before sending**: render a few pages to PNG (`pdftoppm -png -r 50 deck.pdf ~/slides-output/preview`) and look at them — verify fonts rendered as Anton / Inter / Instrument Serif (if letters look like a generic sans-serif, the fonts are not installed: redo the font step in Setup), nothing overlaps the slanted footer, and no text is clipped.
4. Attach **both** `deck.pdf` and `deck.pptx` via `message_user` attachments, in the same message.

The PPTX is typically **~5MB** because it carries the template's embedded media (cover imagery, geometric backgrounds, the REELEVANT logo); the PDF is usually a similar size. These assets are part of the design and must not be stripped.

---

## Choosing a Content Slide Layout — LIBRARY-FIRST

**A library layout is the default. Generic patterns are the exception.** When an approved library design exists for the idea-count or shape of the content, Devin must use it unless there is a specific, articulable reason it doesn't fit. "I felt like building something custom" is not a reason. "I didn't think about it" is not a reason. The library exists precisely so Devin doesn't reinvent the wheel slide after slide.

### Procedure for every content slide

1. **Count the ideas first, before writing any layout code.** Open `references/slide-library.md` and check the slot. If an approved design exists for that count or shape, **use it**. Don't sketch a custom 2-block layout when the 2-idea library entry is right there.
2. **Reframe content to fit the library when possible.** A slide with "Questions in suspense" and "Key problem" is a 2-idea slide — it maps to S3 contrast (left card = list, right card = statement), even if the two ideas aren't a literal "before/after". Two blocks of content, side by side = 2 ideas. Don't talk yourself out of the library because the content "isn't really a comparison".
3. **Only fall back to generic patterns** in `references/content-layouts.md` when (a) no library design exists for that shape, or (b) you've used the same library layout already in the deck and need variety, or (c) the library layout would genuinely distort the content.
4. **State the choice mentally.** Before writing the layout code, name the library entry you're using (e.g. "this is a 2-idea slide → S3 contrast") or, if falling back, name the reason ("no 5-idea library entry → 3-Column Feature Grid + 2-card row").

### Anti-pattern to watch for

When Devin reaches for `add_rect` + custom textboxes to build two side-by-side blocks on a content slide, that is the exact moment to **stop and check the library**. Two-block side-by-side layouts have an approved design (S2 comparison or S3 contrast). Building a custom one is almost always the wrong choice.

## Slide Library (preferred, by idea-count)

See `references/slide-library.md`. It holds the framework, clean backgrounds, and shared helpers for preferred layouts indexed by idea-count.

**Current status:** approved designs exist for **2 ideas** (comparison S2 / contrast S3), **3 ideas** (three cards S1), **4 grouped blocks** (2×2 header-pill cards S4), **timelines** (S7), **pricing/options tables** (S8), and **3-level maturity pyramids** (S9). For idea-counts without a design, fall back to the generic patterns in `references/content-layouts.md`.

### Library layouts override the Inter 24pt default

Library layouts carry **calibrated, pixel-fixed coordinates** reproduced from real approved decks. Their font sizes are part of the calibration — for example, S3 contrast uses **Inter 20 bold** on the left list because the geometry (icon positions, separator lines, card height) is built for that size. Bumping it to 24pt to satisfy the "Inter 24 default" rule will cause text to overflow the calibrated separator lines.

**Rule:** when using a library layout, **keep its specified font sizes**. The Inter 24pt default applies to slides Devin builds from generic patterns or from scratch, not to library reproductions. This is the one and only exception to "Inter is 24pt".

## Content Layout Patterns — APPROVED GENERIC FALLBACK ONLY

**If the library has no slot for your idea-count, fall back to ONE OF THESE 8 PATTERNS ONLY.** Do not invent a 9th custom pattern. Do not assemble rectangles and textboxes by hand. Pick one of the 8 below, which are extracted from approved Reelevant decks and documented in `references/content-layouts.md`.

The **8 approved generic layout patterns:**

1. **3-Column Feature Grid** — headers + bullets per column
2. **2-Column Comparison** — current vs future, option A vs B
3. **Data Table** — black header, alternating rows, yellow total row
4. **Stat Callout** — large Anton number + Inter label
5. **Team Grid** — photo cards on dark background
6. **Mixed Content** — text left, visual right
7. **Objective/KPI Cards** — horizontal pill cards
8. **3D Polygonal Shapes** — faceted pyramid / funnel / custom shapes to explain a concept

**When a concept involves a hierarchy, funnel, progression, or stack, reach for pattern 8 (3D polygonal shapes) instead of plain text.** These faceted low-poly shapes (lighter front faces, darker top/side faces for depth) are a signature of the Reelevant slide style — see examples in the design examples deck.

If none of these 8 fit, the deck architecture itself may be wrong — consider re-scoping the content to fit an approved library layout. Reaching for "something custom" is a red flag that the structure is off.
