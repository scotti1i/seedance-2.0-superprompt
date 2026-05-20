---
name: product-showcase
scenario: "Hero product 360 rotation + feature reveals + brand close-up"
mode: r2v
duration_s: 10
ratio: 9:16
model_variant: seedance2.0fast
verified_on: 2026-05
success_rate: "high — works across product categories"
tags: [ecommerce, product]
variables:
  - name: "${product_name}"
    desc: "product name + form factor"
    example: "Acme cream linen comforter / Stanley tumbler / Apple Watch"
  - name: "${product_material}"
    desc: "key material descriptor"
    example: "cream linen / brushed stainless steel / titanium"
  - name: "${product_feature}"
    desc: "what makes it special"
    example: "filling the seams perfectly / leak-proof spout / always-on display"
  - name: "${brand_logo_location}"
    desc: "where the logo appears"
    example: "embroidered corner / engraved base / dial face"
---

# Product Showcase (E-commerce Hero)

## When to use

10s hero shot for product listing, Shopify reels, or paid ads. Works for
homeware, beauty, electronics, fashion accessories.

## Required assets (R2V)

- `@image1` — clean product hero shot (white or neutral background)
- `@image2` (optional) — product in use / lifestyle context
- `@image3` — product detail / feature close-up
- `@video1` (optional) — reference UGC pacing if you want UGC vibe

## Prompt (paste this)

```
Vertical video 9:16. Overall audio atmosphere: warm cinematic underscore with subtle string swells, no voiceover, soft ambient texture.

[0-3s] @image1 = ${product_name} in clean ${product_material} finish. Hero shot, medium close-up, neutral background. Slow 360-degree orbit around the product, soft top-down key light catching the edges, subtle reflections on the surface. Sound: subtle string swell begins, gentle whoosh as the camera orbits.

[3-7s] @image2 = ${product_name} in use. Cut to lifestyle close-up. Hands interact with the product naturally, revealing the ${product_feature}. Warm tungsten lighting, shallow depth of field. Locked handheld bob. Sound: gentle texture sound (cloth / metal / glass — match the material), string swell rises.

[7-10s] Extreme close-up of @image3 = ${brand_logo_location}, the logo and brand mark in sharp focus. Light catches the engraving / stitching. Camera holds still then slowly pulls back to reveal the full product. Sound: string swell resolves into a soft chime.

Shot on Sony A7S3, natural color, slight film grain, premium commercial realism. Face stable (if hands visible), no distortion, motion fluid, no plastic skin, no oversaturated colors, no on-screen text.
```

## Variable substitution

| Variable | What to replace with | Example |
|---|---|---|
| `${product_name}` | Generic product name | "Acme cream linen comforter" / "Stanley tumbler" |
| `${product_material}` | Hero material | "cream linen" / "brushed stainless steel" |
| `${product_feature}` | Differentiator | "filling the seams perfectly" |
| `${brand_logo_location}` | Logo position | "embroidered corner" / "engraved base" |

## Engineering notes

- **R2V** because we anchor on the actual product image (otherwise the
  model invents a generic version)
- **Premium look** via Sony A7S3 + warm tungsten + shallow DoF
- **Each segment has different shot type**: hero orbit → lifestyle close-up
  → brand engrave. Variety without exceeding 3 segments.
- **No voiceover** intentional — premium commercials are quieter
- **String swell** as audio glue — cohesive without being intrusive

## Risks and badcases

- The product color may shift if you write contradicting colors in the
  prompt — **let the image decide product color**, don't hard-code
- Logo / text on the product is reproduced at ≤ 4 words success rate;
  long brand names will be misspelled. Use post-prod to add brand name
  text overlays if precision matters
- Orbit in 3s is fast; if you want a more contemplative reveal, extend
  segment 1 to 4s and shorten segment 2

## Variants

- **5s mini** — drop segment 2, keep orbit + brand close-up
- **15s extended** — add a 4th segment with hands-free environmental shot
  (the product on a styled table)

## See also

- `../modes/r2v.md`
- `../examples/good/product-rotation.md`
