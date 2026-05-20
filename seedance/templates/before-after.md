---
name: before-after
scenario: "8s split-screen cosmetics or transformation reveal"
mode: r2v
duration_s: 8
ratio: 9:16
model_variant: seedance2.0fast
last_reviewed: 2026-05
tags: [ecommerce, beauty, transformation]
variables:
  - name: "${transformation}"
    desc: "What changes"
    example: "skin clarity after serum / hair texture after treatment / wrinkles smoothed"
  - name: "${product_name}"
    desc: "Product driving the change"
    example: "Acme hydrating serum / La Roche-Posay sunscreen"
---

# Before/After Reveal

## When to use

8s before-after for cosmetics, skincare, dental, fitness, or any
transformation product. Works as paid ad creative or organic conversion
content.

## Required assets (R2V)

- `@image1` — "before" reference (the problem state)
- `@image2` — "after" reference (the solved state)
- `@image3` — the product

## Prompt (paste this)

```
Vertical video 9:16. Overall audio atmosphere: hopeful uplifting underscore — soft electronic pad with a gentle rhythmic pulse, no voiceover, ambient room tone.

[0-3s] @image1 = before state. Close-up shot of the relevant area (skin / hair / smile), soft directional light from camera-left highlighting the texture issue. Locked camera. Sound: pad enters, slight ambient texture, a gentle ticking suggests "this is how things are now".

[3-5s] Cut to medium shot. A hand applies @image3 = ${product_name}, smooth deliberate motion. The product label is briefly visible. Soft warm light. Slow camera bob. Sound: subtle squeeze / pump / brush sound matching the product format, pad rises slightly.

[5-8s] Cut to @image2 = after state. Same close-up framing as segment 1, same soft light from the same angle — but now the ${transformation} is visible. Glow / smoothness / clarity. Slow handheld push-in. Sound: pad resolves into a satisfying chord, a soft chime marks the reveal.

Shot on Sony A7S3, natural skin tone, slight film grain, beauty-editorial realism. Face stable (if face visible), no distortion, motion fluid, no plastic skin, no oversaturated colors, no on-screen text.
```

## Variable substitution

| Variable | What to replace with | Example |
|---|---|---|
| `${transformation}` | The visible change | "skin clarity after serum" |
| `${product_name}` | Product driving it | "Acme hydrating serum" |

## Engineering notes

- **R2V** because before/after states must match in framing — the same
  pose, same light angle, just the transformation differs
- **Critical: same framing in segments 1 and 3** — explicitly call this
  out ("same close-up framing as segment 1, same soft light from the same
  angle"). Otherwise the reveal feels disconnected.
- **Locked → push-in** in the after segment intensifies the reveal
- **Sony A7S3 + beauty-editorial** = magazine-clean skin
- **Audio glue**: pad sustained across segments creates emotional through-
  line; chime marks the resolution

## Risks and badcases

- If `@image1` and `@image2` differ in lighting, the reveal feels like a
  different person. Use the same lighting setup for both reference images.
- Skin-tone shifts can read as "before/after" themselves; freeze skin
  tone explicitly with negatives
- "Long product brand name on screen" — only attempt if name ≤4 common
  English words; otherwise overlay in post
- Some content moderation rules treat unclear "transformation" claims
  loosely; stay clearly aesthetic (not medical claim)

## Variants

- **5s tight** — drop segment 2 (product application), straight before →
  after with the product in segment 2's audio
- **15s extended** — add a 4th beat of testimonial / lifestyle context
- **Hair / fitness** — replace skin close-up with relevant body part

## See also

- `../modes/r2v.md`
