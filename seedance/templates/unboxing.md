---
name: unboxing
scenario: "10s POV unboxing reveal"
mode: r2v
duration_s: 10
ratio: 9:16
model_variant: seedance2.0fast
last_reviewed: 2026-05
tags: [ecommerce, unboxing, pov]
variables:
  - name: "${product_inside}"
    desc: "Product being unboxed"
    example: "a leather-bound notebook / a pair of sneakers / a phone"
  - name: "${box_color}"
    desc: "Box exterior look"
    example: "matte black / pastel pink / kraft brown"
---

# Unboxing POV

## When to use

10s product unboxing shot from the buyer's POV. Works for any consumer
product with a packaging story — fashion, tech, beauty, lifestyle.

## Required assets (R2V)

- `@image1` — sealed box (closed, packaging hero)
- `@image2` — product inside (the reveal hero)
- `@image3` (optional) — final styled product shot

## Prompt (paste this)

```
Vertical video 9:16. Overall audio atmosphere: anticipation underscore — soft synth pad with rising tension, no voiceover, ASMR-foregrounded package sounds.

[0-3s] @image1 = sealed ${box_color} box on a clean surface. POV top-down close-up shot. A pair of hands enters frame, slowly slides off the outer sleeve, lifts the lid. Soft side light. Sound: gentle paper slide, cardboard lift, synth pad rises.

[3-7s] Cut to slightly elevated POV. The lid is now off, tissue paper is folded aside. @image2 = the ${product_inside} revealed inside the box, nestled in pristine packaging. Light reflects off the surface. Slow handheld push-in toward the product. Sound: tissue rustle, then a soft "ah" moment of sound design, synth pad sustains.

[7-10s] @image2 is lifted out of the box and held up to the camera. Camera tilts slightly to show one signature detail. Light catches the finish. Slow camera bob. Sound: synth pad resolves, a soft chime marks completion.

Shot on iPhone 15 Pro, natural color, slight handheld bobbing, premium UGC realism. Face stable (if hands visible), no distortion, motion fluid, no plastic skin, no oversaturated colors, no on-screen text.
```

## Variable substitution

| Variable | What to replace with | Example |
|---|---|---|
| `${product_inside}` | Product type + form | "leather-bound notebook" / "pair of sneakers" |
| `${box_color}` | Box color + finish | "matte black" / "pastel pink" |

## Engineering notes

- **R2V** because the specific packaging matters (color, branding)
- **POV throughout** — buyer's perspective is the unboxing genre's hook
- **Audio-forward** — synth pad + ASMR foley is what makes unboxing feel
  premium
- **3 segments**: lid lift → reveal → hold up. Classic unboxing beat.
- **iPhone 15 Pro** because unboxing is UGC by definition

## Risks and badcases

- If the box and product colors are too similar, the reveal moment lacks
  contrast. Choose contrasting box / product combos.
- "Hands enters frame" can produce extra fingers — keep hand actions
  simple (slide / lift) and the close-up tight
- 10s is the sweet spot — 5s feels rushed, 15s drags

## Variants

- **8s tight** — drop the final hold-up, end on the reveal
- **15s extended** — add a 4th beat of the buyer trying / using the product
- **Multiple-item unboxing** — replace `@image2` with `@image2,3,4` and
  unwrap each in turn (caution: tight on time)

## See also

- `../modes/r2v.md`
- `../templates/product-showcase.md`
