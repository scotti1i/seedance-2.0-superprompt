---
name: "<short descriptive name>"
scenario: "<one-line: who does what, where>"
mode: t2v | i2v | r2v | v2v | frames
duration_s: 5 | 8 | 10 | 15
ratio: 9:16 | 16:9 | 1:1 | 3:4 | 4:3 | 21:9
model_variant: seedance2.0fast | seedance2.0
last_reviewed: YYYY-MM-DD     # date you last reviewed against methodology
demo_video: ""                # OPTIONAL — leave empty unless you have actually run this template and published a real output sample
tags: [ecommerce, lifestyle, narrative, ...]
variables:
  - name: "${var_name}"
    desc: "what to substitute"
    example: "concrete example value"
---

# <Template Name>

## When to use

(2-3 sentences describing the target scenario)

## Required assets

- For T2V: none
- For I2V: 1 anchor image (description of what it should show)
- For R2V: list each `@image_N`, `@video_N`, `@audio_N` and what each
  should show / contain

## Prompt (paste this)

```
(the engineered prompt — copy-pasteable)
```

## Variable substitution

| Variable | What to replace with | Example |
|---|---|---|
| `${product_name}` | the product you're showcasing | "Acme cream linen comforter" |
| `${...}` | ... | ... |

## Engineering notes

- Why this mode / duration / ratio
- Which methodology rules this template obeys
- What's intentionally absent (e.g., subtitles → post-prod)

## Risks and badcases

- Known failure modes
- What to inspect on first output
- When this template breaks

## Variants

- **5s short** — drop segment 2, keep hook + cta
- **15s extended** — add a transition beat between segments 1 and 2

## See also

- `../modes/<mode>.md`
- `../examples/good/<related-example>.md`
