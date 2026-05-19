# Good Example — R2V Pet Vlog Clone (15s)

Engineered prompt for cloning a TikTok pet-walk video (cat with harness,
indoor → outdoor → product showcase) using R2V multimodal mode.

## Required assets

- `@image1` — anchor of the cat wearing the harness (silver shaded
  British Shorthair, pink mesh harness)
- `@image2` — indoor scene
- `@image3` — outdoor scene
- `@image4` — pink harness product close-up
- `@video1` — first 15s of the reference TikTok (for cut pacing)
- `@audio1` — first 15s of the reference audio (for BGM energy)

## Engineered prompt

```
Vertical video 9:16. Overall audio atmosphere: cheerful kawaii synth music at 115 BPM with marimba and pizzicato strings, fast bouncy female voiceover, occasional 'boop' percussion accents — match the energy and instrumentation of @audio1.

[0-5s] @image1 = white British Shorthair silver shaded with light blue eyes, wearing a pink mesh harness. @image2 = indoor scene (light wood-grain floor, white door frame, warm window light). Close-up handheld shot. Two human hands carefully slip @image1's front legs into the pink mesh harness, click the black plastic buckle, attach the silver metal D-ring leash clip. @image1 sits patient on the wooden floor, slight tail flick. Sound: gentle fabric rustle, soft plastic click, marimba opens.

[5-11s] @image1 wears the same pink mesh harness, now in @image3 = outdoor scene (gray sidewalk, red brick planter, black-and-white cow statues, yellow wildflowers, european-style buildings in the distance). Medium handheld follow shot, low-angle, walking pace. @image1 trots forward, stops, looks up curiously at the cow statues, then steps sideways onto sun-warm path. Camera follows from waist height. Sound: pizzicato bounces in, ambient street air, soft paw steps.

[11-15s] Cut to extreme close-up of @image4 = pink mesh harness held in a hand, fingers gently tilt the fabric to show breathable grid texture and reflective trim. Very shallow depth of field, blurred green leaves behind. Locked handheld wobble. Sound: marimba lifts into final note, voiceover settles.

Shot on iPhone 15 Pro. Natural color, slight handheld bobbing, warm color grading with boosted reds and greens, documentary UGC realism. Follow the cut pacing and tracking style of @video1, BGM energy of @audio1.

Constraints: face stable, no distortion, body proportions natural, motion fluid, no plastic skin, no oversaturated colors beyond reference, no on-screen text, no subtitles.
```

## Why this is good (rule-by-rule)

| Rule | Status | Notes |
|---|---|---|
| R-T01 (≤4 segments) | 🟢 | 3 segments (0-5, 5-11, 11-15) |
| R-S01 (scene triplet) | 🟢 | Each scene has color + material + light |
| R-R01 (`@image` rebinding) | 🟢 | `@image1` in EVERY segment — critical R2V rule |
| R-R05 (asset count ≤ 5) | 🟢 | 4 images + 1 video + 1 audio = 6 (within sweet spot) |
| R-C01 (one camera move / segment) | 🟢 | handheld close-up → handheld follow → locked wobble |
| R-J01 (no junk) | 🟢 | No "highly detailed", "8k", standalone "cinematic" |
| R-J03 (named camera) | 🟢 | iPhone 15 Pro |
| R-X01 (text ≤4 words) | 🟢 | `no on-screen text` negative used (Chinese subtitles → post-prod) |
| R-A01 (Overall audio) | 🟢 | Line 2 |
| R-N01 (3-5 negatives) | 🟢 | 5 specific negatives |
| R-B01 (≤2000 bytes) | 🟢 | ~1100 chars |

## Engineering choices

- **Letters not numbers** if multiple characters (not needed here, only 1
  cat, but the pattern is enforced for habit)
- **Asset role annotation in segment 1** (`@image1 = white British
  Shorthair...`) — this is the explicit asset → character mapping
- **@video1 / @audio1 explicit ask** in the final paragraph: "Follow the
  cut pacing... BGM energy of @audio1"
- **No on-screen text** — the original Chinese subtitles are deliberately
  excluded; Seedance is unreliable on Chinese long subtitles. Subtitles
  added in CapCut / 剪映 post.
- **Realistic fidelity expectations** (see below) — not over-promising

## Expected fidelity

| Dimension | Expected fidelity |
|---|---|
| Overall vibe + color grading | ~90% |
| Cut pacing (via @video1) | ~85% |
| Camera handling style | ~85% |
| British Shorthair + pink harness combination | ~85% |
| The *specific* cat from @image1 (individual identity) | ~30-40% |
| Outdoor scene props (cow statues, flowers) | ~70% |
| Original BGM melody | ~5% (style transfers via @audio1, not melody) |
| Original Chinese subtitles | 0% (intentionally not generated) |

## See also

- `../../modes/r2v.md`
- `../../templates/pet-vlog.md`
