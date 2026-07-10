# Advanced Guide — Writing Guidelines

## Target Audience
Data-savvy marketers, CRM managers, and Technical Account Managers
with HIGH data maturity. They understand databases, data modeling,
and complex business logic — but they are NOT developers.

## Tone & Style
- Professional, precise, data-oriented
- Assume familiarity with: databases, CSV/JSON formats, ETL concepts,
  boolean logic, basic SQL concepts, statistical testing basics
- Do NOT assume programming ability or command-line comfort beyond copying a documented `curl` request
- Define every required identifier, token, and payload value before an API example
- Sentence length: up to 35 words
- Use platform vocabulary without additional explanation (reader already knows it)

## Vocabulary Rules
- Use ALL platform terms as-is (Workflow, Node, Branch, Datasource, etc.)
- CAN use: query, schema, field, filter, aggregation, transformation,
  data type, boolean, operator, expression, p-value, confidence interval
- NEVER use: SDK, npm, REST, GraphQL, webhook, deployment, CI/CD,
  Docker, server, middleware
- `curl` and exact HTTP methods are allowed only when the page mentions an API endpoint

## Structure
- Start with "Prerequisites" or "Before you begin" when relevant
- Include worked examples with realistic data (e.g., product catalogs)
- Use tables to document field types, operators, configuration options
- Show "before and after" for transformations
- Include `<Info>` blocks for edge cases and gotchas
- Link to product-guide pages for UI basics
- When mentioning an API endpoint, include one concise `curl` request with placeholders and the required authentication and content-type headers

## What NOT to include
- Code in any programming language, except one concise `curl` request for a documented API endpoint
- API response payload examples
- SDK installation instructions
- Server configuration
