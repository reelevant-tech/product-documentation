# Product Adoption — Writing Guidelines

## Target Audience
Two primary readers:
1. **Existing customers** (CS-led) — Understanding how to measure ROI,
   which Use Cases to activate, and how to prove value internally.
2. **Prospects in evaluation** (Sales-led) — Understanding what business
   problems Reelevant solves and seeing concrete methodology for proving value.

## Tone & Style
- Authoritative, data-driven, pedagogical
- Explain statistical concepts simply but correctly
- Use concrete numbers and worked examples throughout
- Be rigorous — this content must "resist examination by finance and leadership"
- Sentence length: up to 35 words

## Vocabulary Rules
- Use ALL platform terms as canonical (Workflow, Datasource, Content, etc.)
- Use Incremental Value terminology consistently (see glossary):
  - "Exposed Population" (not "test group")
  - "Non-Exposed Population" (not "control group")
  - "Incremental Value" (not "added value" or "generated value")
  - "Uplift" (not "lift" or "improvement")
  - "Key Challenge" (not "problematic" or "pain point")
  - "Use Case" (not "scenario" or "recipe")
- CAN use statistical terms: p-value, confidence interval, significance,
  Z-test, t-test, sample size, observation window
- EXPLAIN statistical terms on first use with plain-language parenthetical

## Structure (Incremental Value pages)
- Always include the formula/calculation
- Always include a concrete worked example with realistic numbers
- Use tables for Exposed vs Non-Exposed comparisons
- Include "What you CAN affirm" and "What you CANNOT affirm" sections
- Flag common mistakes explicitly with `<Warning>` blocks

## Structure (Use Case Explorer pages)
- Each Key Challenge page: problem statement, connected Use Cases, required data
- Each Use Case page: what it is, which challenges it solves, required Datasources,
  required capabilities, example implementation
- Each Datasource page: fields, connected Use Cases, data requirements
- Always show the connections (challenge → Use Case → data → capability)

## What NOT to include
- Code snippets (this is methodology, not implementation)
- Platform UI instructions (link to product-guide)
- Pricing or commercial terms
- Customer-specific data (use anonymised examples)

## Source Material
- Incremental Value Methodology: https://v0-incremental-value-methodology.vercel.app/
- Use Case Explorer: https://v0-use-case-explorer.vercel.app/
- ALL content from these sources must be translated to ENGLISH
- Adapt structure for Mintlify MDX format (cards, tables, steps, callouts)
