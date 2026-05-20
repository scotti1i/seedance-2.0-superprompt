---
name: pet-vlog
scenario: "Take a pet outdoors with a harness, end on product detail showcase"
mode: r2v
duration_s: 15
ratio: 9:16
model_variant: seedance2.0fast
last_reviewed: 2026-05
tags: [lifestyle, pet, ecommerce, viral]
variables:
  - name: "${pet_description}"
    desc: "Specific breed + color + key feature"
    example: "white British Shorthair silver shaded with light blue eyes"
  - name: "${product_description}"
    desc: "Product details: color, material, key feature"
    example: "pink mesh harness with reflective trim"
  - name: "${indoor_scene}"
    desc: "Brief indoor scene description"
    example: "light wood-grain floor, white door frame, warm window light"
  - name: "${outdoor_scene}"
    desc: "Brief outdoor scene description"
    example: "gray sidewalk, red brick planter, yellow wildflowers, european-style buildings"
---

# Pet Vlog (Outdoor Walk + Product Showcase)

## When to use

The proven TikTok / Reels viral format: cute pet wearing a brand-able
accessory, goes outdoors with the owner, ends on a clean product close-up.
Works for any pet (cat / dog / rabbit / ferret) and any wearable product
(harness, collar, carrier, leash, jacket).

## Required assets (R2V)

- `@image1` — anchor frame of the pet wearing the product
- `@image2` — indoor scene
- `@image3` — outdoor scene (street / park / sidewalk)
- `@image4` — product close-up (texture / material detail)
- `@video1` (optional) — reference video for cut pacing (a similar
  pet vlog ≤15s)
- `@audio1` (optional) — reference audio for BGM energy

## Prompt (paste this)

```
Vertical video 9:16. Overall audio atmosphere: cheerful kawaii synth music at 115 BPM with marimba and pizzicato strings, fast bouncy female voiceover, occasional 'boop' percussion accents — match the energy and instrumentation of @audio1.

[0-5s] @image1 = ${pet_description}, wearing ${product_description}. @image2 = ${indoor_scene}. Close-up handheld shot. Two human hands carefully fit @image1 with the ${product_description}, click the buckle, attach the leash clip. @image1 sits patient on the floor, slight tail flick. Sound: gentle fabric rustle, soft plastic click, marimba opens.

[5-11s] @image1 wears the same ${product_description}, now in @image3 = ${outdoor_scene}. Medium handheld follow shot, low-angle, walking pace. @image1 trots forward, stops, looks up curiously, then steps sideways onto the path. Camera follows from waist height. Sound: pizzicato bounces in, ambient street air, soft paw steps.

[11-15s] Cut to extreme close-up of @image4 = the ${product_description} held in a hand, fingers gently tilt the fabric to show the texture and key feature. Very shallow depth of field, blurred greenery behind. Locked handheld wobble. Sound: marimba lifts into final note, voiceover settles.

Shot on iPhone 15 Pro. Natural color, slight handheld bobbing, warm color grading with boosted reds and greens, documentary UGC realism. Follow the cut pacing and tracking style of @video1, BGM energy of @audio1.

Constraints: face stable, no distortion, body proportions natural, motion fluid, no plastic skin, no oversaturated colors beyond reference, no on-screen text, no subtitles.
```

## Variable substitution

| Variable | What to replace with | Example |
|---|---|---|
| `${pet_description}` | Specific breed + colors + key feature | "white British Shorthair silver shaded with light blue eyes" |
| `${product_description}` | Color + material + key feature | "pink mesh harness with reflective trim" |
| `${indoor_scene}` | 2-3 attributes of indoor space | "light wood-grain floor, white door frame, warm window light" |
| `${outdoor_scene}` | 3-4 environmental anchors | "gray sidewalk, red brick planter, yellow wildflowers" |

## Engineering notes

- **R2V mode** chosen because we need character + scene + product all
  anchored separately
- **`@image_N` re-bound in every segment** — prevents pet face drift /
  scene jumps
- **Three segments**: indoor prep → outdoor walk → product close-up. Each
  has its own scene triplet (color + material + light).
- **One camera move per segment**: handheld close-up → handheld follow →
  locked handheld wobble.
- **iPhone 15 Pro** named camera locks the UGC TikTok aesthetic.
- **No on-screen text** in prompt — the original videos have Chinese
  subtitles burned in, but Seedance is unreliable on long Chinese text
  (<20% success). Add subtitles in post (CapCut / 剪映).

## Risks and badcases

- The pet that gets generated may resemble but **not exactly match** the
  pet in `@image1`. Subject identity holds at ~85% for breed match, 30-40%
  for individual identity.
- If `@image1` shows the pet face + legs together, may trip moderation
  (rare for pets, common for humans).
- Product color must match `@image4` — do NOT hard-code the color in the
  prompt if it conflicts with the image (let the image decide).
- 15s is the upper bound for R2V; cuts beyond 3 may collapse.

## Variants

- **10s short** — drop segment 2 (outdoor walk), keep indoor prep +
  product close-up
- **9s tight** — shorten outdoor walk to 4s
- **Indoor-only 8s** — segments 1 + 3 only

## See also

- `../modes/r2v.md` — full R2V handbook
- `../decision-trees/safety-zone.md` — moderation rules
